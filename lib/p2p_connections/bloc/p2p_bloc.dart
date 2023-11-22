import 'dart:async';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pet_cam/p2p_connections/socket_repository.dart';
import 'package:pet_cam/web_rtc/web_rtc_service.dart';

part 'p2p_event.dart';
part 'p2p_state.dart';
part 'p2p_bloc.mapper.dart';

class P2PBloc extends Bloc<P2PEvent, P2PState> {
  P2PBloc({
    required SocketRepository socketRepository,
    required WebRtcService webRtcService,
  })  : _socketRepository = socketRepository,
        _webRtcService = webRtcService,
        super(const P2PState()) {
    on<SocketEmitEvent>(_onSocketEmitEvent);
    on<SocketCreateRoom>(_onSocketCreateRoom);
    on<SocketInitEventListener>(_onSocketInitEventListener);
    on<SocketJoinRoom>(_onSocketJoinRoom);
    on<SocketCloseConnection>(_onSocketCloseConnection);
    on<ToggleCamera>(_onToggleCamera);

    _initIceListener();
  }

  final SocketRepository _socketRepository;
  final WebRtcService _webRtcService;
  RTCSessionDescription? _offer;

  final _iceCandidateList = <Map<String, dynamic>>[];

  Future<void> _onSocketInitEventListener(
    SocketInitEventListener event,
    Emitter<P2PState> emit,
  ) async {
    await emit.onEach(
      _socketRepository.eventStream,
      onData: (eventData) {
        final eventName = eventData['event'] as String?;

        if (eventName == SocketEvents.roomJoined.name) {
          if (_offer != null) {
            _socketRepository.emitSocketEvent(
              SocketEvents.sendWebRtcOffer.name,
              {
                'room': room,
                'offer': _offer!.toMap(),
                'ice': _iceCandidateList,
              },
            );

            _webRtcService.addMediaTracksToPeer();
          }
        }

        if (eventName == SocketEvents.offer.name) {
          _answerRtcOffer(eventData: eventData);
        }

        if (eventName == SocketEvents.roomMessage.name) {
          _handleRemoteRoomMessage(eventData);
        }
      },
    );
  }

  void _handleRemoteRoomMessage(dynamic data) {
    final map = data as Map<String, dynamic>;
    final iceCandidates = map['ice'] as Map<String, dynamic>?;
    final answer = map['answer'] as Map<String, dynamic>?;

    if (iceCandidates != null) {
      final iceCandidate = RTCIceCandidate(
        iceCandidates['candidate'] as String,
        iceCandidates['sdpMid'] as String,
        iceCandidates['sdpMLineIndex'] as int,
      );

      _webRtcService.addIceCandidate(iceCandidate);
    }

    if (answer != null) {
      final offerResponse = RTCSessionDescription(
        answer['sdp'] as String,
        answer['type'] as String,
      );

      _webRtcService.setRemoteDescription(offerResponse);
    }
  }

  Future<void> _answerRtcOffer({
    required Map<String, dynamic> eventData,
  }) async {
    dynamic iceCandidateCallback(RTCIceCandidate? candidate) {
      if (candidate == null) {
        return;
      }

      _socketRepository.emitSocketEvent(SocketEvents.roomMessage.name, {
        'room': room,
        'ice': candidate.toMap(),
      });
    }

    final offer = await _webRtcService.answerOffer(
      data: eventData,
      iceCandidateCallback: iceCandidateCallback,
    );

    _socketRepository.emitSocketEvent(
      SocketEvents.roomMessage.name,
      offer,
    );
  }

  Future<void> _onSocketCreateRoom(
    SocketCreateRoom event,
    Emitter<P2PState> emit,
  ) async {
    await _webRtcService.openUserMedia();
    _offer = await _webRtcService.createRoom();

    _socketRepository.emitSocketEvent(
      SocketEvents.joinRoom.name,
      {'room': room, 'offer': _offer!.toMap()},
    );

    await emit.forEach(
      _webRtcService.remoteMediaStream,
      onData: (mediaStream) {
        return state.copyWith(
          remoteStream: mediaStream,
        );
      },
    );
  }

  Future<void> _onSocketJoinRoom(
    SocketJoinRoom event,
    Emitter<P2PState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.connecting));

    _socketRepository.emitSocketEvent(
      SocketEvents.joinRoom.name,
      {'room': room},
    );

    await emit.onEach(
      _webRtcService.remoteMediaStream,
      onData: (mediaStream) {
        emit(
          state.copyWith(
            connectionStatus: ConnectionStatus.connected,
            remoteStream: mediaStream,
          ),
        );
      },
    );
  }

  Future<void> _onSocketEmitEvent(
    SocketEmitEvent event,
    Emitter<P2PState> emit,
  ) async {
    _socketRepository.emitSocketEvent(
      event.eventName,
      event.data,
    );
  }

  Future<void> _onToggleCamera(
    ToggleCamera event,
    Emitter<P2PState> emit,
  ) async {
    await _webRtcService.toggleCamera();

    emit(
      state.copyWith(
        cameraType: state.cameraType == CameraType.front
            ? CameraType.rear
            : CameraType.front,
      ),
    );
  }

  Future<void> _onSocketCloseConnection(
    SocketCloseConnection event,
    Emitter<P2PState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.disconnecting));

    await _webRtcService.closeConnection(
      localVideo: event.localVideo,
      remoteStream: state.remoteStream,
    );

    emit(state.copyWith(connectionStatus: ConnectionStatus.disconnected));
  }

  void _initIceListener() {
    _webRtcService.iceCandidateStream.listen(_iceCandidateList.add);
  }

  @override
  Future<void> close() {
    _webRtcService.dispose();
    return super.close();
  }
}

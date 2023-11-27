import 'dart:async';
import 'dart:developer';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pet_cam/p2p_connections/socket_message.dart';
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
    on<InitSocketEventListener>(_onInitSocketEventListener);
    on<EmitSocketEvent>(_onEmitSocketEvent);
    on<CreateAndSendRtcOffer>(_onCreateAndSendRtcOffer);
    on<ConnectToRemoteCamera>(_onConnectToRemoteCamera);
    on<CloseConnection>(_onCloseConnection);
    on<ToggleCamera>(_onToggleCamera);

    _initIceListener();
  }

  final SocketRepository _socketRepository;
  final WebRtcService _webRtcService;
  RTCSessionDescription? _offer;

  final _iceCandidateList = <Map<String, dynamic>>[];

  Future<void> _onInitSocketEventListener(
    InitSocketEventListener event,
    Emitter<P2PState> emit,
  ) async {
    await emit.onEach(
      _socketRepository.eventStream,
      onData: (eventData) async {
        final eventName = eventData['event'] as String;
        _logP2PBloc('event name: $eventName');

        if (eventName == SocketEvents.roomJoined.name && _offer != null) {
          if (!_webRtcService.isPeerConnectionInitialized) {
            _offer = await _webRtcService.createAndSendRtcOffer();
          }
          _socketRepository.emitSocketEvent(
            SocketMessage(
              event: SocketEvents.sendWebRtcOffer.name,
              room: room,
              outputEvent: 'offer',
              data: {
                'room': room,
                'offer': _offer!.toMap(),
                'ice': _iceCandidateList,
              },
            ),
          );

          await _webRtcService.addMediaTracksToPeer();
        }

        if (eventName == SocketEvents.offer.name) {
          await _answerRtcOffer(eventData);
        }

        if (eventName == SocketEvents.roomMessage.name) {
          _handleRemoteRoomMessage(eventData);
        }

        if (eventName == SocketEvents.disconnect.name) {
          await _webRtcService.closeConnection(
            remoteStream: state.remoteStream,
          );
        }
      },
    );
  }

  Future<void> _onCreateAndSendRtcOffer(
    CreateAndSendRtcOffer event,
    Emitter<P2PState> emit,
  ) async {
    _offer = await _webRtcService.createAndSendRtcOffer();

    _socketRepository.emitSocketEvent(
      SocketMessage(
        event: SocketEvents.joinRoom.name,
        room: room,
        outputEvent: SocketEvents.roomJoined.name,
        data: {'offer': _offer!.toMap()},
      ),
    );
  }

  Future<void> _onConnectToRemoteCamera(
    ConnectToRemoteCamera event,
    Emitter<P2PState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.connecting));

    _socketRepository.emitSocketEvent(
      SocketMessage(
        event: SocketEvents.joinRoom.name,
        room: room,
        outputEvent: SocketEvents.roomJoined.name,
        data: {},
      ),
    );

    await emit.forEach(
      _webRtcService.remoteMediaStream,
      onData: (mediaStream) => state.copyWith(
        connectionStatus: ConnectionStatus.connected,
        remoteStream: mediaStream,
      ),
    );
  }

  Future<void> _onEmitSocketEvent(
    EmitSocketEvent event,
    Emitter<P2PState> emit,
  ) async {
    _socketRepository.emitSocketEvent(
      SocketMessage(
        event: event.eventName,
        room: room,
        outputEvent: SocketEvents.roomMessage.name,
        data: event.data,
      ),
    );
  }

  Future<void> _onToggleCamera(
    ToggleCamera event,
    Emitter<P2PState> emit,
  ) async {
    await _webRtcService.toggleCamera();
  }

  Future<void> _onCloseConnection(
    CloseConnection event,
    Emitter<P2PState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.disconnecting));

    await _webRtcService.closeConnection(
      localVideo: event.localVideo,
      remoteStream: state.remoteStream,
    );

    _socketRepository.emitSocketEvent(
      SocketMessage(
        event: SocketEvents.roomMessage.name,
        room: room,
        outputEvent: SocketEvents.disconnect.name,
        data: {},
      ),
    );

    emit(state.copyWith(connectionStatus: ConnectionStatus.disconnected));
  }

  void _handleRemoteRoomMessage(dynamic data) {
    final map = data as Map<String, dynamic>;
    _logP2PBloc('room message $map');

    final iceCandidates = map['ice'] as Map<String, dynamic>?;
    final answer = map['answer'] as Map<String, dynamic>?;
    final init = map['init'] as Map<String, dynamic>?;

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

    if (init != null) {}
  }

  Future<void> _answerRtcOffer(
    Map<String, dynamic> eventData,
  ) async {
    dynamic iceCandidateCallback(RTCIceCandidate? candidate) {
      if (candidate == null) {
        return;
      }

      _socketRepository.emitSocketEvent(
        SocketMessage(
          event: SocketEvents.roomMessage.name,
          room: room,
          outputEvent: SocketEvents.roomMessage.name,
          data: {
            'room': room,
            'ice': candidate.toMap(),
          },
        ),
      );
    }

    final offer = await _webRtcService.answerOffer(
      data: eventData,
      iceCandidateCallback: iceCandidateCallback,
    );

    _socketRepository.emitSocketEvent(
      SocketMessage(
        event: SocketEvents.roomMessage.name,
        room: room,
        outputEvent: SocketEvents.roomMessage.name,
        data: offer,
      ),
    );
  }

  void _initIceListener() {
    _webRtcService.iceCandidateStream.listen(_iceCandidateList.add);
  }

  void _logP2PBloc(String message) {
    log(message, name: 'P2PBloc');
  }

  @override
  Future<void> close() {
    _webRtcService.dispose();
    return super.close();
  }
}

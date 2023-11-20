import 'dart:async';
import 'dart:developer';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pet_cam/env.dart';
import 'package:pet_cam/sockets/bloc/socket_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;

const _room = 'pet_cam_room';

class SocketRepository {
  SocketRepository({
    socket.Socket? socketio,
  }) : _socket = socketio ??
            socket.io(
              // _localHost,
              Env.serverUrl,
              <String, dynamic>{
                'transports': ['websocket'],
                'autoConnect': false,
              },
            ) {
    _initSocketListeners();
  }

  final configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ],
      }
    ],
  };

  static const _localHost = 'http://192.168.1.120:8000/';

  final socket.Socket _socket;

  final _localMediaStreamController = StreamController<MediaStream>();
  final _remoteMediaStreamController = StreamController<MediaStream>();

  Stream<MediaStream> get localMediaStream =>
      _localMediaStreamController.stream;
  Stream<MediaStream> get remoteMediaStream =>
      _remoteMediaStreamController.stream;

  void _initSocketListeners() {
    _socket
      ..connect()
      ..onConnect((data) => log('Connected ${_socket.connected}'))
      ..on(
        SocketEvents.roomJoined.name,
        (_) => _sendOffer(),
      )
      ..on(
        SocketEvents.roomMessage.name,
        _handleRemoteRoomMessage,
      )
      ..on(
        SocketEvents.offer.name,
        _answerOffer,
      );
  }

  RTCPeerConnection? _peerConnection;
  MediaStream? localStream;
  String? currentRoomText;
  RTCSessionDescription? offer;

  final iceList = <Map<String, dynamic>>[];

  Future<void> createRoom() async {
    _logSocketRepository(
      'Create PeerConnection with configuration: $configuration',
    );

    _peerConnection = await createPeerConnection(configuration);

    _registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, localStream!);
    });

    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      iceList.add(candidate.toMap() as Map<String, dynamic>);
    };
    // Finish Code for collecting ICE candidate

    // Add code for creating a room
    offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer!);
    _logSocketRepository('Created offer: $offer');

    final roomWithOffer = <String, dynamic>{'offer': offer!.toMap()};

    _socket.emit(
      SocketEvents.joinRoom.name,
      {'room': _room, 'offer': roomWithOffer},
    );
  }

  Future<void> _sendOffer() async {
    _socket.emit(
      SocketEvents.sendWebRtcOffer.name,
      {
        'room': _room,
        'offer': offer!.toMap(),
        'ice': iceList,
      },
    );

    _peerConnection?.onTrack = (RTCTrackEvent event) {
      _logSocketRepository('Got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((track) {
        _logSocketRepository('Add a track to the remoteStream $track');
        _remoteMediaStreamController.add(event.streams[0]);
      });
    };
  }

  Future<void> _answerOffer(dynamic data) async {
    final offer =
        (data as Map<String, dynamic>)['offer'] as Map<String, dynamic>;
    final iceList = data['ice'] as List?;
    _logSocketRepository(
      '_answerOffer: Received offer: ice $iceList',
    );
    _peerConnection = await createPeerConnection(configuration);

    _registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, localStream!);
    });

    _peerConnection!.onIceCandidate = (RTCIceCandidate? candidate) {
      if (candidate == null) {
        _logSocketRepository('onIceCandidate: complete!');
        return;
      }
      _socket.emit(SocketEvents.roomMessage.name, {
        'room': _room,
        'ice': candidate.toMap(),
      });
      _logSocketRepository('onIceCandidate: ${candidate.toMap()}');
    };

    _peerConnection?.onTrack = (RTCTrackEvent event) {
      _logSocketRepository('Got remote track: ${event.streams[0]}');
      event.streams[0].getTracks().forEach((track) {
        _logSocketRepository('Add a track to the remoteStream: $track');
        _remoteMediaStreamController.add(event.streams[0]);
      });
    };
    await _peerConnection?.setRemoteDescription(
      RTCSessionDescription(offer['sdp'] as String, offer['type'] as String),
    );

    final answer = await _peerConnection!.createAnswer();
    _logSocketRepository('Created Answer $answer');

    await _peerConnection!.setLocalDescription(answer);

    final roomWithAnswer = <String, dynamic>{
      'type': answer.type,
      'sdp': answer.sdp,
    };

    _socket.emit(
      SocketEvents.roomMessage.name,
      {
        'room': _room,
        'answer': roomWithAnswer,
      },
    );
  }

  Future<void> joinRoom() async {
    _socket.emit(
      SocketEvents.joinRoom.name,
      {'room': _room},
    );
  }

  Future<void> openUserMedia() async {
    final mediaConstraints = <String, dynamic>{
      'audio': false,
      'video': {
        'mandatory': {
          'minWidth':
              '500', // Provide your own width, height and frame rate here
          'minHeight': '500',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': <dynamic>[],
      },
    };
    try {
      final stream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);

      _logSocketRepository('Got stream $stream');

      localStream = stream;

      _remoteMediaStreamController.add(await createLocalMediaStream('key'));
    } catch (e) {
      _logSocketRepository('openUserMedia ERROR: $e');
    }
  }

  void _handleRemoteRoomMessage(dynamic data) {
    final map = data as Map<String, dynamic>;
    final iceCandidates = map['ice'] as Map<String, dynamic>?;
    final answer = map['answer'] as Map<String, dynamic>?;
    _logSocketRepository('message data $data');

    if (iceCandidates != null) {
      _logSocketRepository('Ice candidate $iceCandidates');
      _peerConnection?.addCandidate(
        RTCIceCandidate(
          iceCandidates['candidate'] as String,
          iceCandidates['sdpMid'] as String,
          iceCandidates['sdpMLineIndex'] as int,
        ),
      );
    }

    if (answer != null) {
      final offerResponse = RTCSessionDescription(
        answer['sdp'] as String,
        answer['type'] as String,
      );

      _logSocketRepository('Remote client responded with SDP: $offerResponse');
      _peerConnection?.setRemoteDescription(offerResponse);
    }
  }

  void _registerPeerConnectionListeners() {
    _peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      _logSocketRepository('ICE gathering state changed: $state');
    };

    _peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      _logSocketRepository('Connection state change: $state');
    };

    _peerConnection?.onSignalingState = (RTCSignalingState state) {
      _logSocketRepository('Signaling state change: $state');
    };

    _peerConnection?.onAddStream = (MediaStream stream) {
      _logSocketRepository('onAddStream $stream');
      _remoteMediaStreamController.add(stream);
    };
  }

  void emitSocketEvent(String eventName, Map<String, dynamic> message) {
    _socket.emit(eventName, message);
  }

  void _logSocketRepository(String message) {
    log(message, name: 'SocketRepository');
  }

  void dispose() {
    _remoteMediaStreamController.close();
  }
}

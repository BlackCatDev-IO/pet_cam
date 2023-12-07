import 'dart:async';
import 'dart:developer';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_cam/analytics/analytics_service.dart';

const _room = 'pet_cam_room';

typedef IceCandidateCallback = dynamic Function(RTCIceCandidate);

class WebRtcService {
  RTCPeerConnection? _peerConnection;
  RTCSessionDescription? offer;
  MediaStream? localStream;

  final _remoteMediaStreamController =
      StreamController<MediaStream>.broadcast();

  Stream<MediaStream> get remoteMediaStream =>
      _remoteMediaStreamController.stream;

  final StreamController<Map<String, dynamic>> _iceCandidateController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get iceCandidateStream =>
      _iceCandidateController.stream;

  final StreamController<RTCPeerConnectionState> _signalingStateController =
      StreamController<RTCPeerConnectionState>.broadcast();

  Stream<RTCPeerConnectionState> get signalingState =>
      _signalingStateController.stream;

  static const _configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ],
      }
    ],
  };

  final _analytics = GetIt.I<AnalyticsService>();

  bool get isPeerConnectionInitialized => _peerConnection != null;

  Future<RTCSessionDescription> createAndSendRtcOffer() async {
    await _openUserMedia();
    _logWebRtcService(
      'Create PeerConnection with configuration: $_configuration',
    );

    _peerConnection = await createPeerConnection(_configuration);

    _registerPeerConnectionListeners();

    // Gets local media stream from device camera and adds it to the peer
    // connection
    localStream?.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, localStream!);
    });

    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      _iceCandidateController.add(candidate.toMap() as Map<String, dynamic>);
    };

    offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer!);
    _logWebRtcService('Created offer: $offer');

    return offer!;
  }

  Future<void> addMediaTracksToPeer() async {
    _peerConnection?.onTrack = (RTCTrackEvent event) {
      _logWebRtcService('Got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((track) {
        _logWebRtcService('Add a track to the remoteStream $track');
        _remoteMediaStreamController.add(event.streams[0]);
      });
    };
  }

  Future<Map<String, dynamic>> answerOffer({
    required dynamic data,
    required IceCandidateCallback iceCandidateCallback,
  }) async {
    final offer =
        (data as Map<String, dynamic>)['offer'] as Map<String, dynamic>;

    final iceList = data['ice'] as List?;

    _logWebRtcService('_answerOffer: Received offer: ice $iceList');

    _peerConnection = await createPeerConnection(_configuration);

    _registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      _logWebRtcService('Add a track to the localStream: $track');

      _peerConnection?.addTrack(track, localStream!);
    });

    _peerConnection!.onIceCandidate = iceCandidateCallback;
    _peerConnection?.onTrack = (RTCTrackEvent event) {
      _logWebRtcService('Got remote track: ${event.streams[0]}');
      event.streams[0].getTracks().forEach((track) {
        _logWebRtcService('Add a track to the remoteStream: $track');
        _remoteMediaStreamController.add(event.streams[0]);
      });
    };

    await _peerConnection?.setRemoteDescription(
      RTCSessionDescription(
        offer['sdp'] as String,
        offer['type'] as String,
      ),
    );

    final answer = await _peerConnection!.createAnswer();

    _logWebRtcService('Created Answer $answer');

    await _peerConnection!.setLocalDescription(answer);

    final roomWithAnswer = <String, dynamic>{
      'type': answer.type,
      'sdp': answer.sdp,
    };

    return {
      'room': _room,
      'answer': roomWithAnswer,
    };
  }

  void addIceCandidate(RTCIceCandidate iceCandidate) {
    if (_peerConnection?.connectionState !=
        RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
      _peerConnection?.addCandidate(iceCandidate);
    }
  }

  void setRemoteDescription(RTCSessionDescription offerResponse) {
    _peerConnection?.setRemoteDescription(offerResponse);
  }

  Future<void> _openUserMedia() async {
    final mediaConstraints = <String, dynamic>{
      'audio': false,
      'video': {
        'mandatory': {
          'minWidth': '500',
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

      _logWebRtcService('Got stream $stream');

      localStream = stream;

      _remoteMediaStreamController.add(await createLocalMediaStream('key'));
    } catch (e) {
      _logWebRtcService('openUserMedia ERROR: $e');
    }
  }

  Future<void> toggleCamera() async {
    if (localStream == null) {
      throw Exception('Stream is not initialized');
    }

    final videoTrack = localStream!
        .getVideoTracks()
        .firstWhere((track) => track.kind == 'video');

    await Helper.switchCamera(videoTrack);
  }

  void _registerPeerConnectionListeners() {
    _peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      _logWebRtcService(
        'PeerConnection ICE gathering state changed: $state',
      );
    };

    _peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      _analytics.track('WebRTC Connection state change: $state');
      _logWebRtcService('PeerConnection Connection state change: $state');
      _signalingStateController.add(state);
    };

    _peerConnection?.onSignalingState = (RTCSignalingState state) {
      _analytics.track('WebRTC Signaling state change: $state');
      _logWebRtcService('PeerConnection Signaling state change: $state');
    };

    _peerConnection?.onAddStream = (MediaStream stream) {
      _logWebRtcService('PeerConnection onAddStream $stream');
      _remoteMediaStreamController.add(stream);
    };
  }

  Future<void> closeConnection({
    RTCVideoRenderer? localVideo,
    required MediaStream? remoteStream,
  }) async {
    _logWebRtcService('Closing connection');
    if (localVideo?.srcObject != null) {
      localVideo!.srcObject!.getTracks().forEach((track) => track.stop());
      localVideo.srcObject = null;
    }

    if (remoteStream != null) {
      remoteStream.getTracks().forEach((track) => track.stop());
    }

    if (_peerConnection != null) {
      await _peerConnection!.close();
      _peerConnection = null;
    }

    await localStream?.dispose();
    await remoteStream?.dispose();
  }

  void _logWebRtcService(String message) {
    log(message, name: 'WebRTCService');
  }

  void dispose() {
    _remoteMediaStreamController.close();
  }
}

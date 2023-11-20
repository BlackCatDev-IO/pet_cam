part of 'socket_bloc.dart';

enum SocketEvents {
  connect('connect'),
  send('send'),
  roomMessage('room_message'),
  roomJoined('room_joined'),
  offer('offer'),
  sendWebRtcOffer('send_webrtc_offer'),
  joinRoom('join_room');

  const SocketEvents(this.name);

  final String name;
}

enum CameraType {
  front,
  rear,
}

@MappableClass()
class SocketState with SocketStateMappable {
  const SocketState({
    this.data = '',
    this.roomId = 'pet_cam_room',
    this.receivedMessages = const [],
    this.localStream,
    this.remoteStream,
    this.cameraType = CameraType.rear,
  });

  final String data;
  final List<String> receivedMessages;
  final String roomId;
  final MediaStream? localStream;
  final MediaStream? remoteStream;
  final CameraType cameraType;
}

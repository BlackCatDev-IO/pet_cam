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

@MappableEnum()
enum ConnectionStatus {
  connecting,
  connected,
  disconnecting,
  disconnected,
  error,
}

extension ConnectionStatusX on ConnectionStatus {
  bool get isDisconnecting => this == ConnectionStatus.disconnecting;
  bool get isConnecting => this == ConnectionStatus.connecting;
  bool get isConnected => this == ConnectionStatus.connected;
  bool get isDisconnected => this == ConnectionStatus.disconnected;
  bool get isError => this == ConnectionStatus.error;
}

@MappableClass()
class SocketState with SocketStateMappable {
  const SocketState({
    this.connectionStatus = ConnectionStatus.disconnected,
    this.data = '',
    this.roomId = 'pet_cam_room',
    this.receivedMessages = const [],
    this.localStream,
    this.remoteStream,
    this.cameraType = CameraType.rear,
  });

  final ConnectionStatus connectionStatus;
  final String data;
  final List<String> receivedMessages;
  final String roomId;
  final MediaStream? localStream;
  final MediaStream? remoteStream;
  final CameraType cameraType;
}

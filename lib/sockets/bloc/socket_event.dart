part of 'socket_bloc.dart';

abstract class SocketEvent {}

class SocketEmitEvent extends SocketEvent {
  SocketEmitEvent({
    required this.eventName,
    required this.data,
  });

  final String eventName;
  final Map<String, dynamic> data;
}

class SocketInitEventListener extends SocketEvent {}

class SocketCreateRoom extends SocketEvent {
  SocketCreateRoom();
}

class SocketJoinRoom extends SocketEvent {}

class SocketCloseConnection extends SocketEvent {
  SocketCloseConnection({
    required this.localVideo,
  });

  final RTCVideoRenderer localVideo;
}

class ToggleCamera extends SocketEvent {}

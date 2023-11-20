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

class SocketCreateRoom extends SocketEvent {
  SocketCreateRoom({
    required this.localVideo,
    required this.remoteVideo,
  });

  final RTCVideoRenderer localVideo;
  final RTCVideoRenderer remoteVideo;
}

class SocketJoinRoom extends SocketEvent {}

class OpenUserMedia extends SocketEvent {}

class ToggleCamera extends SocketEvent {}

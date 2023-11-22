part of 'p2p_bloc.dart';

abstract class P2PEvent {}

class SocketEmitEvent extends P2PEvent {
  SocketEmitEvent({
    required this.eventName,
    required this.data,
  });

  final String eventName;
  final Map<String, dynamic> data;
}

class SocketInitEventListener extends P2PEvent {}

class SocketCreateRoom extends P2PEvent {
  SocketCreateRoom();
}

class SocketJoinRoom extends P2PEvent {}

class SocketCloseConnection extends P2PEvent {
  SocketCloseConnection({
    required this.localVideo,
  });

  final RTCVideoRenderer localVideo;
}

class ToggleCamera extends P2PEvent {}

part of 'p2p_bloc.dart';

abstract class P2PEvent {}

class EmitSocketEvent extends P2PEvent {
  EmitSocketEvent({
    required this.eventName,
    required this.data,
  });

  final String eventName;
  final Map<String, dynamic> data;
}

class InitSocketEventListener extends P2PEvent {}

class InitConnectionFromClient extends P2PEvent {}

class CreateSocketRoom extends P2PEvent {}

class JoinSocketRoom extends P2PEvent {}

class CloseConnection extends P2PEvent {
  CloseConnection({
    required this.localVideo,
  });

  final RTCVideoRenderer localVideo;
}

class ToggleCamera extends P2PEvent {}
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

class SocketInitListener extends SocketEvent {}

part of 'socket_bloc.dart';

enum SocketEvents {
  connect('connect'),
  status('status'),
  send('send'),
  receive('receive');

  const SocketEvents(this.name);
  
  final String name;
}

@MappableClass()
class SocketState with SocketStateMappable {
  const SocketState({
    this.data = '',
    this.receivedMessages = const [],
  });

  final String data;
  final List<String> receivedMessages;
}

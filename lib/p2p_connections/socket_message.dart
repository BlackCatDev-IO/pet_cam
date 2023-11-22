import 'package:dart_mappable/dart_mappable.dart';

part 'socket_message.mapper.dart';

@MappableClass()
class SocketMessage with SocketMessageMappable {
  SocketMessage({
    required this.event,
    required this.room,
    required this.outputEvent,
    required this.data,
  });

  final String event;
  final String room;
  final String outputEvent;
  final Map<String, dynamic> data;

  static const fromMap = SocketMessageMapper.fromMap;
}

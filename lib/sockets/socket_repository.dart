import 'dart:async';
import 'dart:developer';

import 'package:pet_cam/env.dart';
import 'package:pet_cam/sockets/bloc/socket_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;

class SocketRepository {
  SocketRepository({
    socket.Socket? socketio,
  }) : _socket = socketio ??
            socket.io(
              Env.serverUrl,
              <String, dynamic>{
                'transports': ['websocket'],
                'autoConnect': false,
              },
            ) {
    _initSocketListeners();
  }

  final socket.Socket _socket;

  final _eventsStreamController = StreamController<String>();

  Stream<String> get eventStream => _eventsStreamController.stream;

  void _initSocketListeners() {
    _socket
      ..connect()
      ..onConnect((data) {
        log('Connected ${_socket.connected}');
      })
      ..on(
        SocketEvents.receive.name,
        (data) {
          final message = (data as Map)['data'] as String;
          final timestamp = data['timestamp'] as String;
          final receivedMessage =
              'Socket Message From Server $message at $timestamp';
          log(receivedMessage);
          _eventsStreamController.add(receivedMessage);
        },
      );
  }

  void emitSocketEvent(String eventName, Map<String, dynamic> message) {
    _socket.emit(eventName, message);
  }

  void dispose() {
    _eventsStreamController.close();
  }
}

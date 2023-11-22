import 'dart:async';
import 'dart:developer';

import 'package:pet_cam/env.dart';
import 'package:pet_cam/p2p_connections/bloc/p2p_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;

const room = 'pet_cam_room';
const localHost = 'http://192.168.1.120:8000/';

class SocketRepository {
  SocketRepository({
    socket.Socket? socketio,
  }) : _socket = socketio ??
            socket.io(
              // localHost,
              Env.serverUrl,
              <String, dynamic>{
                'transports': ['websocket'],
                'autoConnect': false,
              },
            ) {
    _initSocketListeners();
  }

  final socket.Socket _socket;

  final _socketEventController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get eventStream => _socketEventController.stream;

  void _initSocketListeners() {
    final expectedSocketEvents =
        SocketEvents.values.map((event) => event.name).toList();
    _socket
      ..connect()
      ..onConnect(
        (data) => _logSocketRepository(
          'Connected to socket.io server: ${_socket.connected}',
        ),
      )
      ..onAny(
        (event, data) {
          if (expectedSocketEvents.contains(event) && data != null) {
            final map = data as Map<String, dynamic>;
            map['event'] = event;
            _socketEventController.add(map);
          }
        },
      );
  }

  void emitSocketEvent(String eventName, Map<String, dynamic> message) {
    _socket.emit(eventName, message);
  }

  void _logSocketRepository(String message) {
    log(message, name: 'SocketRepository');
  }
}

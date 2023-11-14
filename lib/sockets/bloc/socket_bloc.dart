import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_cam/sockets/socket_repository.dart';

part 'socket_event.dart';
part 'socket_state.dart';
part 'socket_bloc.mapper.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketBloc({required SocketRepository socketRepository})
      : _socketRepository = socketRepository,
        super(const SocketState()) {
    on<SocketInitListener>(_onSocketInitListener);
    on<SocketEmitEvent>(_onSocketEmitEvent);
  }

  final SocketRepository _socketRepository;

  Future<void> _onSocketInitListener(
    SocketInitListener event,
    Emitter<SocketState> emit,
  ) async {
    await emit.forEach(
      _socketRepository.eventStream,
      onData: (data) => state.copyWith(
        data: data,
        receivedMessages: [
          ...state.receivedMessages,
          data,
        ],
      ),
    );
  }

  Future<void> _onSocketEmitEvent(
    SocketEmitEvent event,
    Emitter<SocketState> emit,
  ) async {
    _socketRepository.emitSocketEvent(
      event.eventName,
      event.data,
    );
  }

  @override
  Future<void> close() {
    _socketRepository.dispose();
    return super.close();
  }
}

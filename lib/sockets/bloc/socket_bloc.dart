import 'dart:async';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pet_cam/sockets/socket_repository.dart';

part 'socket_event.dart';
part 'socket_state.dart';
part 'socket_bloc.mapper.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketBloc({required SocketRepository socketRepository})
      : _socketRepository = socketRepository,
        super(const SocketState()) {
    on<SocketEmitEvent>(_onSocketEmitEvent);
    on<SocketCreateRoom>(_onSocketCreateRoom);
    on<SocketJoinRoom>(_onSocketJoinRoom);
    on<SocketCloseConnection>(_onSocketCloseConnection);
    on<ToggleCamera>(_onToggleCamera);
  }

  final SocketRepository _socketRepository;

  Future<void> _onSocketCreateRoom(
    SocketCreateRoom event,
    Emitter<SocketState> emit,
  ) async {
    await _socketRepository.createRoom();
    await emit.forEach(
      _socketRepository.remoteMediaStream,
      onData: (mediaStream) {
        return state.copyWith(
          remoteStream: mediaStream,
        );
      },
    );
  }

  Future<void> _onSocketJoinRoom(
    SocketJoinRoom event,
    Emitter<SocketState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.connecting));
    await _socketRepository.joinRoom();

    await emit.onEach(
      _socketRepository.remoteMediaStream,
      onData: (mediaStream) {
        emit(
          state.copyWith(
            connectionStatus: ConnectionStatus.connected,
            remoteStream: mediaStream,
          ),
        );
      },
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

  Future<void> _onToggleCamera(
    ToggleCamera event,
    Emitter<SocketState> emit,
  ) async {
    await _socketRepository.toggleCamera();

    emit(
      state.copyWith(
        cameraType: state.cameraType == CameraType.front
            ? CameraType.rear
            : CameraType.front,
      ),
    );
  }

  Future<void> _onSocketCloseConnection(
    SocketCloseConnection event,
    Emitter<SocketState> emit,
  ) async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.disconnecting));

    await _socketRepository.closeConnection(
      localVideo: event.localVideo,
      remoteStream: state.remoteStream,
    );

    emit(state.copyWith(connectionStatus: ConnectionStatus.disconnected));
  }

  @override
  Future<void> close() {
    _socketRepository.dispose();
    return super.close();
  }
}

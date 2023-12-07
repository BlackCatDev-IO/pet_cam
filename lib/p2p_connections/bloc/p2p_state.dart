// ignore_for_file: sort_constructors_first

part of 'p2p_bloc.dart';

enum ConnectionStatus {
  connecting,
  connected,
  disconnecting,
  disconnected,
  error;

  bool get isDisconnecting => this == ConnectionStatus.disconnecting;
  bool get isConnecting => this == ConnectionStatus.connecting;
  bool get isConnected => this == ConnectionStatus.connected;
  bool get isDisconnected => this == ConnectionStatus.disconnected;
  bool get isError => this == ConnectionStatus.error;
}

enum DeviceRole {
  viewer,
  camera,
  notSet;

  bool get isCamera => this == DeviceRole.camera;
  bool get isViewer => this == DeviceRole.viewer;
  bool get isNotSet => this == DeviceRole.notSet;
}

class P2PState extends Equatable {
  const P2PState({
    this.connectionStatus = ConnectionStatus.disconnected,
    this.deviceRole = DeviceRole.notSet,
    this.localStream,
    this.remoteStream,
  });

  final ConnectionStatus connectionStatus;
  final DeviceRole deviceRole;
  final MediaStream? localStream;
  final MediaStream? remoteStream;

  factory P2PState.fromMap(Map<String, dynamic> map) {
    final deviceRoleString = map['deviceRole'] as String;

    final deviceRole = DeviceRole.values.firstWhere(
      (element) => element.name == deviceRoleString,
      orElse: () => DeviceRole.notSet,
    );

    return P2PState(
      deviceRole: deviceRole,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceRole': deviceRole.name,
    };
  }

  P2PState copyWith({
    ConnectionStatus? connectionStatus,
    DeviceRole? deviceRole,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return P2PState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
      deviceRole: deviceRole ?? this.deviceRole,
      localStream: localStream ?? this.localStream,
      remoteStream: remoteStream ?? this.remoteStream,
    );
  }

  @override
  List<Object?> get props => [
        connectionStatus,
        deviceRole,
        localStream,
        remoteStream,
      ];
}

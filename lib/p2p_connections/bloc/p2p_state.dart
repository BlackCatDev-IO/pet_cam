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

class P2PState extends Equatable {
  const P2PState({
    this.connectionStatus = ConnectionStatus.disconnected,
    this.localStream,
    this.remoteStream,
  });

  final ConnectionStatus connectionStatus;
  final MediaStream? localStream;
  final MediaStream? remoteStream;

  factory P2PState.fromMap(Map<String, dynamic> map) {
    final statusString = map['connectionStatus'] as String;
    final status = ConnectionStatus.values.firstWhere(
      (element) => element.name == statusString,
      orElse: () => ConnectionStatus.disconnected,
    );
    return P2PState(
      connectionStatus: status,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'connectionStatus': connectionStatus.name,
    };
  }

  P2PState copyWith({
    ConnectionStatus? connectionStatus,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) {
    return P2PState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
      localStream: localStream ?? this.localStream,
      remoteStream: remoteStream ?? this.remoteStream,
    );
  }

  @override
  List<Object?> get props => [
        connectionStatus,
        localStream,
        remoteStream,
      ];
}

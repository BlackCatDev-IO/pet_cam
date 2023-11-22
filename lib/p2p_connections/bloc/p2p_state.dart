part of 'p2p_bloc.dart';

@MappableEnum()
enum ConnectionStatus {
  connecting,
  connected,
  disconnecting,
  disconnected,
  error,
}

extension ConnectionStatusX on ConnectionStatus {
  bool get isDisconnecting => this == ConnectionStatus.disconnecting;
  bool get isConnecting => this == ConnectionStatus.connecting;
  bool get isConnected => this == ConnectionStatus.connected;
  bool get isDisconnected => this == ConnectionStatus.disconnected;
  bool get isError => this == ConnectionStatus.error;
}

@MappableClass()
class P2PState with P2PStateMappable {
  const P2PState({
    this.connectionStatus = ConnectionStatus.disconnected,
    this.localStream,
    this.remoteStream,
  });

  final ConnectionStatus connectionStatus;
  final MediaStream? localStream;
  final MediaStream? remoteStream;
}

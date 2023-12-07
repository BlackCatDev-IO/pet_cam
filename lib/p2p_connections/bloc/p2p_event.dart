part of 'p2p_bloc.dart';

sealed class P2PEvent {}

class InitSignalStateListener extends P2PEvent {}

class CreateAndSendRtcOffer extends P2PEvent {}

class ConnectToRemoteCamera extends P2PEvent {}

class CloseConnection extends P2PEvent {
  CloseConnection({
    required this.localVideo,
  });

  final RTCVideoRenderer localVideo;
}

class ToggleCamera extends P2PEvent {}

class SetDeviceRole extends P2PEvent {
  SetDeviceRole({required this.deviceRole});

  final DeviceRole deviceRole;
}

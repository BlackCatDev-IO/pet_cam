part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class SetDeviceRole extends SettingsEvent {
  SetDeviceRole({required this.deviceRole});

  final DeviceRole deviceRole;
}

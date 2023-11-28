part of 'settings_bloc.dart';

@MappableEnum()
enum CameraType {
  front,
  rear,
}

@MappableEnum()
enum DeviceRole {
  viewer,
  camera,
  notSet,
}

extension DeviceRoleX on DeviceRole {
  bool get isCamera => this == DeviceRole.camera;
  bool get isViewer => this == DeviceRole.viewer;
  bool get isNotSet => this == DeviceRole.notSet;
}

@MappableClass()
class SettingsState with SettingsStateMappable {
  const SettingsState({
    this.cameraType = CameraType.front,
    this.deviceRole = DeviceRole.notSet,
  });

  final CameraType cameraType;
  final DeviceRole deviceRole;

  static const fromMap = SettingsStateMapper.fromMap;
}

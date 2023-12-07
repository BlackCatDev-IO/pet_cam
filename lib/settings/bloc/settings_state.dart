part of 'settings_bloc.dart';

@MappableEnum()
enum CameraType {
  front,
  rear,
}


@MappableClass()
class SettingsState with SettingsStateMappable {
  const SettingsState({
    this.cameraType = CameraType.front,
  });

  final CameraType cameraType;

  static const fromMap = SettingsStateMapper.fromMap;
}

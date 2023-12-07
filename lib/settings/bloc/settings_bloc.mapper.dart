// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_bloc.dart';

class CameraTypeMapper extends EnumMapper<CameraType> {
  CameraTypeMapper._();

  static CameraTypeMapper? _instance;
  static CameraTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CameraTypeMapper._());
    }
    return _instance!;
  }

  static CameraType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CameraType decode(dynamic value) {
    switch (value) {
      case 'front':
        return CameraType.front;
      case 'rear':
        return CameraType.rear;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CameraType self) {
    switch (self) {
      case CameraType.front:
        return 'front';
      case CameraType.rear:
        return 'rear';
    }
  }
}

extension CameraTypeMapperExtension on CameraType {
  String toValue() {
    CameraTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CameraType>(this) as String;
  }
}

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      CameraTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  static CameraType _$cameraType(SettingsState v) => v.cameraType;
  static const Field<SettingsState, CameraType> _f$cameraType =
      Field('cameraType', _$cameraType, opt: true, def: CameraType.front);

  @override
  final Map<Symbol, Field<SettingsState, dynamic>> fields = const {
    #cameraType: _f$cameraType,
  };

  static SettingsState _instantiate(DecodingData data) {
    return SettingsState(cameraType: data.dec(_f$cameraType));
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsState>(map);
  }

  static SettingsState fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsState>(json);
  }
}

mixin SettingsStateMappable {
  String toJson() {
    return SettingsStateMapper.ensureInitialized()
        .encodeJson<SettingsState>(this as SettingsState);
  }

  Map<String, dynamic> toMap() {
    return SettingsStateMapper.ensureInitialized()
        .encodeMap<SettingsState>(this as SettingsState);
  }

  SettingsStateCopyWith<SettingsState, SettingsState, SettingsState>
      get copyWith => _SettingsStateCopyWithImpl(
          this as SettingsState, $identity, $identity);
  @override
  String toString() {
    return SettingsStateMapper.ensureInitialized()
        .stringifyValue(this as SettingsState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SettingsStateMapper.ensureInitialized()
                .isValueEqual(this as SettingsState, other));
  }

  @override
  int get hashCode {
    return SettingsStateMapper.ensureInitialized()
        .hashValue(this as SettingsState);
  }
}

extension SettingsStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsState, $Out> {
  SettingsStateCopyWith<$R, SettingsState, $Out> get $asSettingsState =>
      $base.as((v, t, t2) => _SettingsStateCopyWithImpl(v, t, t2));
}

abstract class SettingsStateCopyWith<$R, $In extends SettingsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({CameraType? cameraType});
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsState, $Out>
    implements SettingsStateCopyWith<$R, SettingsState, $Out> {
  _SettingsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsState> $mapper =
      SettingsStateMapper.ensureInitialized();
  @override
  $R call({CameraType? cameraType}) => $apply(
      FieldCopyWithData({if (cameraType != null) #cameraType: cameraType}));
  @override
  SettingsState $make(CopyWithData data) =>
      SettingsState(cameraType: data.get(#cameraType, or: $value.cameraType));

  @override
  SettingsStateCopyWith<$R2, SettingsState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingsStateCopyWithImpl($value, $cast, t);
}

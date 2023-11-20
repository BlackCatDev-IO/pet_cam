// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'socket_bloc.dart';

class SocketStateMapper extends ClassMapperBase<SocketState> {
  SocketStateMapper._();

  static SocketStateMapper? _instance;
  static SocketStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocketStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SocketState';

  static String _$data(SocketState v) => v.data;
  static const Field<SocketState, String> _f$data =
      Field('data', _$data, opt: true, def: '');
  static String _$roomId(SocketState v) => v.roomId;
  static const Field<SocketState, String> _f$roomId =
      Field('roomId', _$roomId, opt: true, def: 'pet_cam_room');
  static List<String> _$receivedMessages(SocketState v) => v.receivedMessages;
  static const Field<SocketState, List<String>> _f$receivedMessages =
      Field('receivedMessages', _$receivedMessages, opt: true, def: const []);
  static MediaStream? _$localStream(SocketState v) => v.localStream;
  static const Field<SocketState, MediaStream> _f$localStream =
      Field('localStream', _$localStream, opt: true);
  static MediaStream? _$remoteStream(SocketState v) => v.remoteStream;
  static const Field<SocketState, MediaStream> _f$remoteStream =
      Field('remoteStream', _$remoteStream, opt: true);
  static CameraType _$cameraType(SocketState v) => v.cameraType;
  static const Field<SocketState, CameraType> _f$cameraType =
      Field('cameraType', _$cameraType, opt: true, def: CameraType.rear);

  @override
  final Map<Symbol, Field<SocketState, dynamic>> fields = const {
    #data: _f$data,
    #roomId: _f$roomId,
    #receivedMessages: _f$receivedMessages,
    #localStream: _f$localStream,
    #remoteStream: _f$remoteStream,
    #cameraType: _f$cameraType,
  };

  static SocketState _instantiate(DecodingData data) {
    return SocketState(
        data: data.dec(_f$data),
        roomId: data.dec(_f$roomId),
        receivedMessages: data.dec(_f$receivedMessages),
        localStream: data.dec(_f$localStream),
        remoteStream: data.dec(_f$remoteStream),
        cameraType: data.dec(_f$cameraType));
  }

  @override
  final Function instantiate = _instantiate;

  static SocketState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocketState>(map);
  }

  static SocketState fromJson(String json) {
    return ensureInitialized().decodeJson<SocketState>(json);
  }
}

mixin SocketStateMappable {
  String toJson() {
    return SocketStateMapper.ensureInitialized()
        .encodeJson<SocketState>(this as SocketState);
  }

  Map<String, dynamic> toMap() {
    return SocketStateMapper.ensureInitialized()
        .encodeMap<SocketState>(this as SocketState);
  }

  SocketStateCopyWith<SocketState, SocketState, SocketState> get copyWith =>
      _SocketStateCopyWithImpl(this as SocketState, $identity, $identity);
  @override
  String toString() {
    return SocketStateMapper.ensureInitialized()
        .stringifyValue(this as SocketState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SocketStateMapper.ensureInitialized()
                .isValueEqual(this as SocketState, other));
  }

  @override
  int get hashCode {
    return SocketStateMapper.ensureInitialized().hashValue(this as SocketState);
  }
}

extension SocketStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocketState, $Out> {
  SocketStateCopyWith<$R, SocketState, $Out> get $asSocketState =>
      $base.as((v, t, t2) => _SocketStateCopyWithImpl(v, t, t2));
}

abstract class SocketStateCopyWith<$R, $In extends SocketState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get receivedMessages;
  $R call(
      {String? data,
      String? roomId,
      List<String>? receivedMessages,
      MediaStream? localStream,
      MediaStream? remoteStream,
      CameraType? cameraType});
  SocketStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocketStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocketState, $Out>
    implements SocketStateCopyWith<$R, SocketState, $Out> {
  _SocketStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocketState> $mapper =
      SocketStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get receivedMessages => ListCopyWith(
          $value.receivedMessages,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(receivedMessages: v));
  @override
  $R call(
          {String? data,
          String? roomId,
          List<String>? receivedMessages,
          Object? localStream = $none,
          Object? remoteStream = $none,
          CameraType? cameraType}) =>
      $apply(FieldCopyWithData({
        if (data != null) #data: data,
        if (roomId != null) #roomId: roomId,
        if (receivedMessages != null) #receivedMessages: receivedMessages,
        if (localStream != $none) #localStream: localStream,
        if (remoteStream != $none) #remoteStream: remoteStream,
        if (cameraType != null) #cameraType: cameraType
      }));
  @override
  SocketState $make(CopyWithData data) => SocketState(
      data: data.get(#data, or: $value.data),
      roomId: data.get(#roomId, or: $value.roomId),
      receivedMessages:
          data.get(#receivedMessages, or: $value.receivedMessages),
      localStream: data.get(#localStream, or: $value.localStream),
      remoteStream: data.get(#remoteStream, or: $value.remoteStream),
      cameraType: data.get(#cameraType, or: $value.cameraType));

  @override
  SocketStateCopyWith<$R2, SocketState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SocketStateCopyWithImpl($value, $cast, t);
}

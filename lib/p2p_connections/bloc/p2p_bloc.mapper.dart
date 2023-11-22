// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'p2p_bloc.dart';

class ConnectionStatusMapper extends EnumMapper<ConnectionStatus> {
  ConnectionStatusMapper._();

  static ConnectionStatusMapper? _instance;
  static ConnectionStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConnectionStatusMapper._());
    }
    return _instance!;
  }

  static ConnectionStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ConnectionStatus decode(dynamic value) {
    switch (value) {
      case 'connecting':
        return ConnectionStatus.connecting;
      case 'connected':
        return ConnectionStatus.connected;
      case 'disconnecting':
        return ConnectionStatus.disconnecting;
      case 'disconnected':
        return ConnectionStatus.disconnected;
      case 'error':
        return ConnectionStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ConnectionStatus self) {
    switch (self) {
      case ConnectionStatus.connecting:
        return 'connecting';
      case ConnectionStatus.connected:
        return 'connected';
      case ConnectionStatus.disconnecting:
        return 'disconnecting';
      case ConnectionStatus.disconnected:
        return 'disconnected';
      case ConnectionStatus.error:
        return 'error';
    }
  }
}

extension ConnectionStatusMapperExtension on ConnectionStatus {
  String toValue() {
    ConnectionStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ConnectionStatus>(this) as String;
  }
}

class P2PStateMapper extends ClassMapperBase<P2PState> {
  P2PStateMapper._();

  static P2PStateMapper? _instance;
  static P2PStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = P2PStateMapper._());
      ConnectionStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'P2PState';

  static ConnectionStatus _$connectionStatus(P2PState v) => v.connectionStatus;
  static const Field<P2PState, ConnectionStatus> _f$connectionStatus = Field(
      'connectionStatus', _$connectionStatus,
      opt: true, def: ConnectionStatus.disconnected);
  static String _$data(P2PState v) => v.data;
  static const Field<P2PState, String> _f$data =
      Field('data', _$data, opt: true, def: '');
  static String _$roomId(P2PState v) => v.roomId;
  static const Field<P2PState, String> _f$roomId =
      Field('roomId', _$roomId, opt: true, def: 'pet_cam_room');
  static List<String> _$receivedMessages(P2PState v) => v.receivedMessages;
  static const Field<P2PState, List<String>> _f$receivedMessages =
      Field('receivedMessages', _$receivedMessages, opt: true, def: const []);
  static MediaStream? _$localStream(P2PState v) => v.localStream;
  static const Field<P2PState, MediaStream> _f$localStream =
      Field('localStream', _$localStream, opt: true);
  static MediaStream? _$remoteStream(P2PState v) => v.remoteStream;
  static const Field<P2PState, MediaStream> _f$remoteStream =
      Field('remoteStream', _$remoteStream, opt: true);
  static CameraType _$cameraType(P2PState v) => v.cameraType;
  static const Field<P2PState, CameraType> _f$cameraType =
      Field('cameraType', _$cameraType, opt: true, def: CameraType.rear);

  @override
  final Map<Symbol, Field<P2PState, dynamic>> fields = const {
    #connectionStatus: _f$connectionStatus,
    #data: _f$data,
    #roomId: _f$roomId,
    #receivedMessages: _f$receivedMessages,
    #localStream: _f$localStream,
    #remoteStream: _f$remoteStream,
    #cameraType: _f$cameraType,
  };

  static P2PState _instantiate(DecodingData data) {
    return P2PState(
        connectionStatus: data.dec(_f$connectionStatus),
        data: data.dec(_f$data),
        roomId: data.dec(_f$roomId),
        receivedMessages: data.dec(_f$receivedMessages),
        localStream: data.dec(_f$localStream),
        remoteStream: data.dec(_f$remoteStream),
        cameraType: data.dec(_f$cameraType));
  }

  @override
  final Function instantiate = _instantiate;

  static P2PState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<P2PState>(map);
  }

  static P2PState fromJson(String json) {
    return ensureInitialized().decodeJson<P2PState>(json);
  }
}

mixin P2PStateMappable {
  String toJson() {
    return P2PStateMapper.ensureInitialized()
        .encodeJson<P2PState>(this as P2PState);
  }

  Map<String, dynamic> toMap() {
    return P2PStateMapper.ensureInitialized()
        .encodeMap<P2PState>(this as P2PState);
  }

  P2PStateCopyWith<P2PState, P2PState, P2PState> get copyWith =>
      _P2PStateCopyWithImpl(this as P2PState, $identity, $identity);
  @override
  String toString() {
    return P2PStateMapper.ensureInitialized().stringifyValue(this as P2PState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            P2PStateMapper.ensureInitialized()
                .isValueEqual(this as P2PState, other));
  }

  @override
  int get hashCode {
    return P2PStateMapper.ensureInitialized().hashValue(this as P2PState);
  }
}

extension P2PStateValueCopy<$R, $Out> on ObjectCopyWith<$R, P2PState, $Out> {
  P2PStateCopyWith<$R, P2PState, $Out> get $asP2PState =>
      $base.as((v, t, t2) => _P2PStateCopyWithImpl(v, t, t2));
}

abstract class P2PStateCopyWith<$R, $In extends P2PState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get receivedMessages;
  $R call(
      {ConnectionStatus? connectionStatus,
      String? data,
      String? roomId,
      List<String>? receivedMessages,
      MediaStream? localStream,
      MediaStream? remoteStream,
      CameraType? cameraType});
  P2PStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _P2PStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, P2PState, $Out>
    implements P2PStateCopyWith<$R, P2PState, $Out> {
  _P2PStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<P2PState> $mapper =
      P2PStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get receivedMessages => ListCopyWith(
          $value.receivedMessages,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(receivedMessages: v));
  @override
  $R call(
          {ConnectionStatus? connectionStatus,
          String? data,
          String? roomId,
          List<String>? receivedMessages,
          Object? localStream = $none,
          Object? remoteStream = $none,
          CameraType? cameraType}) =>
      $apply(FieldCopyWithData({
        if (connectionStatus != null) #connectionStatus: connectionStatus,
        if (data != null) #data: data,
        if (roomId != null) #roomId: roomId,
        if (receivedMessages != null) #receivedMessages: receivedMessages,
        if (localStream != $none) #localStream: localStream,
        if (remoteStream != $none) #remoteStream: remoteStream,
        if (cameraType != null) #cameraType: cameraType
      }));
  @override
  P2PState $make(CopyWithData data) => P2PState(
      connectionStatus:
          data.get(#connectionStatus, or: $value.connectionStatus),
      data: data.get(#data, or: $value.data),
      roomId: data.get(#roomId, or: $value.roomId),
      receivedMessages:
          data.get(#receivedMessages, or: $value.receivedMessages),
      localStream: data.get(#localStream, or: $value.localStream),
      remoteStream: data.get(#remoteStream, or: $value.remoteStream),
      cameraType: data.get(#cameraType, or: $value.cameraType));

  @override
  P2PStateCopyWith<$R2, P2PState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _P2PStateCopyWithImpl($value, $cast, t);
}

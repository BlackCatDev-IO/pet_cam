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
  static MediaStream? _$localStream(P2PState v) => v.localStream;
  static const Field<P2PState, MediaStream> _f$localStream =
      Field('localStream', _$localStream, opt: true);
  static MediaStream? _$remoteStream(P2PState v) => v.remoteStream;
  static const Field<P2PState, MediaStream> _f$remoteStream =
      Field('remoteStream', _$remoteStream, opt: true);

  @override
  final Map<Symbol, Field<P2PState, dynamic>> fields = const {
    #connectionStatus: _f$connectionStatus,
    #localStream: _f$localStream,
    #remoteStream: _f$remoteStream,
  };

  static P2PState _instantiate(DecodingData data) {
    return P2PState(
        connectionStatus: data.dec(_f$connectionStatus),
        localStream: data.dec(_f$localStream),
        remoteStream: data.dec(_f$remoteStream));
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
  $R call(
      {ConnectionStatus? connectionStatus,
      MediaStream? localStream,
      MediaStream? remoteStream});
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
  $R call(
          {ConnectionStatus? connectionStatus,
          Object? localStream = $none,
          Object? remoteStream = $none}) =>
      $apply(FieldCopyWithData({
        if (connectionStatus != null) #connectionStatus: connectionStatus,
        if (localStream != $none) #localStream: localStream,
        if (remoteStream != $none) #remoteStream: remoteStream
      }));
  @override
  P2PState $make(CopyWithData data) => P2PState(
      connectionStatus:
          data.get(#connectionStatus, or: $value.connectionStatus),
      localStream: data.get(#localStream, or: $value.localStream),
      remoteStream: data.get(#remoteStream, or: $value.remoteStream));

  @override
  P2PStateCopyWith<$R2, P2PState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _P2PStateCopyWithImpl($value, $cast, t);
}

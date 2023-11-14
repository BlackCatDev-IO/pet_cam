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
  static List<String> _$receivedMessages(SocketState v) => v.receivedMessages;
  static const Field<SocketState, List<String>> _f$receivedMessages =
      Field('receivedMessages', _$receivedMessages, opt: true, def: const []);

  @override
  final Map<Symbol, Field<SocketState, dynamic>> fields = const {
    #data: _f$data,
    #receivedMessages: _f$receivedMessages,
  };

  static SocketState _instantiate(DecodingData data) {
    return SocketState(
        data: data.dec(_f$data),
        receivedMessages: data.dec(_f$receivedMessages));
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
  $R call({String? data, List<String>? receivedMessages});
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
  $R call({String? data, List<String>? receivedMessages}) =>
      $apply(FieldCopyWithData({
        if (data != null) #data: data,
        if (receivedMessages != null) #receivedMessages: receivedMessages
      }));
  @override
  SocketState $make(CopyWithData data) => SocketState(
      data: data.get(#data, or: $value.data),
      receivedMessages:
          data.get(#receivedMessages, or: $value.receivedMessages));

  @override
  SocketStateCopyWith<$R2, SocketState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SocketStateCopyWithImpl($value, $cast, t);
}

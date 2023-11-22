// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'socket_message.dart';

class SocketMessageMapper extends ClassMapperBase<SocketMessage> {
  SocketMessageMapper._();

  static SocketMessageMapper? _instance;
  static SocketMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocketMessageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SocketMessage';

  static String _$event(SocketMessage v) => v.event;
  static const Field<SocketMessage, String> _f$event = Field('event', _$event);
  static String _$room(SocketMessage v) => v.room;
  static const Field<SocketMessage, String> _f$room = Field('room', _$room);
  static String _$outputEvent(SocketMessage v) => v.outputEvent;
  static const Field<SocketMessage, String> _f$outputEvent =
      Field('outputEvent', _$outputEvent);
  static Map<String, dynamic> _$data(SocketMessage v) => v.data;
  static const Field<SocketMessage, Map<String, dynamic>> _f$data =
      Field('data', _$data);

  @override
  final Map<Symbol, Field<SocketMessage, dynamic>> fields = const {
    #event: _f$event,
    #room: _f$room,
    #outputEvent: _f$outputEvent,
    #data: _f$data,
  };

  static SocketMessage _instantiate(DecodingData data) {
    return SocketMessage(
        event: data.dec(_f$event),
        room: data.dec(_f$room),
        outputEvent: data.dec(_f$outputEvent),
        data: data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static SocketMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocketMessage>(map);
  }

  static SocketMessage fromJson(String json) {
    return ensureInitialized().decodeJson<SocketMessage>(json);
  }
}

mixin SocketMessageMappable {
  String toJson() {
    return SocketMessageMapper.ensureInitialized()
        .encodeJson<SocketMessage>(this as SocketMessage);
  }

  Map<String, dynamic> toMap() {
    return SocketMessageMapper.ensureInitialized()
        .encodeMap<SocketMessage>(this as SocketMessage);
  }

  SocketMessageCopyWith<SocketMessage, SocketMessage, SocketMessage>
      get copyWith => _SocketMessageCopyWithImpl(
          this as SocketMessage, $identity, $identity);
  @override
  String toString() {
    return SocketMessageMapper.ensureInitialized()
        .stringifyValue(this as SocketMessage);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SocketMessageMapper.ensureInitialized()
                .isValueEqual(this as SocketMessage, other));
  }

  @override
  int get hashCode {
    return SocketMessageMapper.ensureInitialized()
        .hashValue(this as SocketMessage);
  }
}

extension SocketMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocketMessage, $Out> {
  SocketMessageCopyWith<$R, SocketMessage, $Out> get $asSocketMessage =>
      $base.as((v, t, t2) => _SocketMessageCopyWithImpl(v, t, t2));
}

abstract class SocketMessageCopyWith<$R, $In extends SocketMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get data;
  $R call(
      {String? event,
      String? room,
      String? outputEvent,
      Map<String, dynamic>? data});
  SocketMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocketMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocketMessage, $Out>
    implements SocketMessageCopyWith<$R, SocketMessage, $Out> {
  _SocketMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocketMessage> $mapper =
      SocketMessageMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get data => MapCopyWith($value.data,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(data: v));
  @override
  $R call(
          {String? event,
          String? room,
          String? outputEvent,
          Map<String, dynamic>? data}) =>
      $apply(FieldCopyWithData({
        if (event != null) #event: event,
        if (room != null) #room: room,
        if (outputEvent != null) #outputEvent: outputEvent,
        if (data != null) #data: data
      }));
  @override
  SocketMessage $make(CopyWithData data) => SocketMessage(
      event: data.get(#event, or: $value.event),
      room: data.get(#room, or: $value.room),
      outputEvent: data.get(#outputEvent, or: $value.outputEvent),
      data: data.get(#data, or: $value.data));

  @override
  SocketMessageCopyWith<$R2, SocketMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SocketMessageCopyWithImpl($value, $cast, t);
}

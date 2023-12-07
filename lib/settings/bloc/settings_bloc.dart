import 'package:dart_mappable/dart_mappable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.mapper.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState());

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsStateMapper.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toMap();
  }
}

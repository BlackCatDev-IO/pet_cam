import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'lifecycle_state.dart';

class LifecycleCubit extends Cubit<LifecycleState> {
  LifecycleCubit() : super(const LifecycleState()) {
    _init();
  }

  late final AppLifecycleListener _listener;

  void _init() {
    _listener = AppLifecycleListener(
      onStateChange: (appState) {
        emit(state.copyWith(appLifecycleState: appState));
      },
    );
  }

  @override
  Future<void> close() {
    _listener.dispose();
    return super.close();
  }
}

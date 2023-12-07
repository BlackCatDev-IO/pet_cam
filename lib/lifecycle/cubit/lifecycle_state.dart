part of 'lifecycle_cubit.dart';

class LifecycleState {
  const LifecycleState({
    this.appLifecycleState = AppLifecycleState.detached,
  });

  final AppLifecycleState appLifecycleState;

  LifecycleState copyWith({
    AppLifecycleState? appLifecycleState,
  }) {
    return LifecycleState(
      appLifecycleState: appLifecycleState ?? this.appLifecycleState,
    );
  }

  @override
  String toString() => 'LifecycleState $appLifecycleState)';
}

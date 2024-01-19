part of 'pause_bloc.dart';

class PauseState {
  const PauseState({
    this.isPaused = false,
  });

  final bool isPaused;

  PauseState copyWith({
    bool? isPaused,
  }) =>
      PauseState(
        isPaused: isPaused ?? this.isPaused,
      );
}

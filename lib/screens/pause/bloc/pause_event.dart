part of 'pause_bloc.dart';

abstract class PauseEvent {
  const PauseEvent();
}

class PauseGame extends PauseEvent {
  const PauseGame({this.isPaused = true});

  final bool isPaused;
}

part of 'player_bloc.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class IncreaseLife extends PlayerEvent {
  const IncreaseLife();
}

class DecreaseLife extends PlayerEvent {
  const DecreaseLife();
}

class ResetLife extends PlayerEvent {
  const ResetLife();
}

class UpdateCurrentGame extends PlayerEvent {
  const UpdateCurrentGame({required this.gameName});

  final String gameName;
}

class UpdateCurrentGameWin extends PlayerEvent {
  const UpdateCurrentGameWin({required this.isWin});

  final bool isWin;
}

class UpdatePoint extends PlayerEvent {
  const UpdatePoint();
}

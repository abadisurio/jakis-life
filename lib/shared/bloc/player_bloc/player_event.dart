part of 'player_bloc.dart';

abstract class PlayerEvent {
  const PlayerEvent();
}

class PlayerInitialize extends PlayerEvent {
  const PlayerInitialize();
}

class PlayerSignIn extends PlayerEvent {
  const PlayerSignIn();
}

class PlayerSignOut extends PlayerEvent {
  const PlayerSignOut();
}

class IncreasePoint extends PlayerEvent {
  const IncreasePoint();
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

class EarnBadge extends PlayerEvent {
  const EarnBadge();
}

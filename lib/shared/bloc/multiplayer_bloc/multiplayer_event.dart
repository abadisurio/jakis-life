part of 'multiplayer_bloc.dart';

class MultiplayerEvent {
  const MultiplayerEvent();
}

class StartMultiplayerSession extends MultiplayerEvent {
  const StartMultiplayerSession({
    required this.invitedId,
  });

  final String invitedId;
}

class StandbyGame extends MultiplayerEvent {
  const StandbyGame();
}

class UpdateScore extends MultiplayerEvent {
  const UpdateScore({required this.score});

  final int score;
}

class UpdateState extends MultiplayerEvent {
  const UpdateState({required this.playersState});

  final String playersState;
}

class UpdateRemotePlayerData extends MultiplayerEvent {
  const UpdateRemotePlayerData({
    this.playersScore,
    this.playersState,
  });

  final int? playersScore;
  final String? playersState;
}

class StartGame extends MultiplayerEvent {
  const StartGame();
}

part of 'multiplayer_bloc.dart';

class MultiplayerEvent {
  const MultiplayerEvent();
}

class StartMultiplayerSession extends MultiplayerEvent {
  const StartMultiplayerSession({
    this.invitedId,
    this.challengeId,
  });

  final String? invitedId;
  final String? challengeId;
}

class UpdatePlayers extends MultiplayerEvent {
  const UpdatePlayers({required this.players});

  final List<JakisLifePlayer> players;
}

class StandbyGame extends MultiplayerEvent {
  const StandbyGame();
}

class ResetMultiplayer extends MultiplayerEvent {
  const ResetMultiplayer();
}

class UpdateScore extends MultiplayerEvent {
  const UpdateScore({required this.score});

  final int score;
}

class UpdateState extends MultiplayerEvent {
  const UpdateState({required this.playersState});

  final String playersState;
}

class UpdatePlayerData extends MultiplayerEvent {
  const UpdatePlayerData({
    this.playersScore,
    this.playersState,
  });

  final int? playersScore;
  final String? playersState;
}

class StartGame extends MultiplayerEvent {
  const StartGame();
}

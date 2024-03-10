part of 'lobby_multiplayer_bloc.dart';

class LobbyMultiplayerEvent {
  const LobbyMultiplayerEvent();
}

class StartMultiplayerSession extends LobbyMultiplayerEvent {
  const StartMultiplayerSession({
    required this.invitedId,
  });

  final String invitedId;
}

class StandbyGame extends LobbyMultiplayerEvent {
  const StandbyGame();
}

class UpdateScore extends LobbyMultiplayerEvent {
  const UpdateScore({required this.score});

  final int score;
}

class UpdateState extends LobbyMultiplayerEvent {
  const UpdateState({required this.playersState});

  final String playersState;
}

class UpdatePlayerData extends LobbyMultiplayerEvent {
  const UpdatePlayerData({
    this.playersScore,
    this.playersState,
  });

  final int? playersScore;
  final String? playersState;
}

class StartGame extends LobbyMultiplayerEvent {
  const StartGame();
}

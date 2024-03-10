part of 'lobby_multiplayer_bloc.dart';

class LobbyMultiplayerState {
  const LobbyMultiplayerState({
    this.challengeId,
    this.playersState,
  });

  final String? challengeId;
  final String? playersState;

  LobbyMultiplayerState copyWith({
    String? challengeId,
    String? playersState,
  }) {
    return LobbyMultiplayerState(
      challengeId: challengeId ?? this.challengeId,
      playersState: playersState ?? this.playersState,
    );
  }
}

class PlayersState {
  static const waiting = 'waiting';
  static const standby = 'standby';
  static const playing = 'playing';
  static const ended = 'ended';
  static const error = 'error';
}

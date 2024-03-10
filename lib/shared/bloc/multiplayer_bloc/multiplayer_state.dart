part of 'multiplayer_bloc.dart';

class MultiplayerState {
  const MultiplayerState({
    this.challengeId,
    this.playersState,
  });

  final String? challengeId;
  final String? playersState;

  MultiplayerState copyWith({
    String? challengeId,
    String? playersState,
  }) {
    return MultiplayerState(
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

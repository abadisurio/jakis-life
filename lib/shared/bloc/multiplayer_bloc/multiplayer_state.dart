part of 'multiplayer_bloc.dart';

class MultiplayerState {
  const MultiplayerState({
    this.challengeId,
    this.opponentIds,
    this.playersState,
    this.players,
  });

  final String? challengeId;
  final String? opponentIds;
  final String? playersState;

  final List<JakisLifePlayer>? players;

  JakisLifePlayer? get self => players
      ?.where((player) => player.id == FirebaseAuth.instance.currentUser?.uid)
      .firstOrNull;
  List<JakisLifePlayer>? get opponents =>
      players?.where((player) => player.id != self?.id).toList();

  MultiplayerState copyWith({
    String? challengeId,
    String? opponentIds,
    String? playersState,
    List<JakisLifePlayer>? players,
  }) {
    return MultiplayerState(
      challengeId: challengeId ?? this.challengeId,
      opponentIds: opponentIds ?? this.opponentIds,
      playersState: playersState ?? this.playersState,
      players: players ?? this.players,
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

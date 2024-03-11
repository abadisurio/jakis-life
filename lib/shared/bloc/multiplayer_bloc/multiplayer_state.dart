part of 'multiplayer_bloc.dart';

class MultiplayerState {
  const MultiplayerState({
    this.challengeId,
    this.opponentIds,
    this.playersState,
    this.opponentDisplayName,
    this.opponentPhotoUrl,
  });

  final String? challengeId;
  final String? opponentIds;
  final String? playersState;
  final String? opponentDisplayName;
  final String? opponentPhotoUrl;

  MultiplayerState copyWith({
    String? challengeId,
    String? opponentIds,
    String? playersState,
    String? opponentDisplayName,
    String? opponentPhotoUrl,
  }) {
    return MultiplayerState(
      challengeId: challengeId ?? this.challengeId,
      opponentIds: opponentIds ?? this.opponentIds,
      playersState: playersState ?? this.playersState,
      opponentDisplayName: opponentDisplayName ?? this.opponentPhotoUrl,
      opponentPhotoUrl: opponentPhotoUrl ?? this.opponentPhotoUrl,
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

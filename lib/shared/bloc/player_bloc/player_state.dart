part of 'player_bloc.dart';

@freezed
class PlayerState with _$PlayerState {
  @JsonSerializable(explicitToJson: true)
  const factory PlayerState({
    @Default(AuthState.loading) AuthState authState,
    @Default(3) int life,
    @Default(0) int latestScore,
    @Default(0) int highScore,
    JakisLifePlayer? user,
    int? badgeSeries,
    String? currentGame,
    @Default(false) bool isCurrentGameWin,
    @Default(false) bool isMultiplayerUnlocked,
  }) = _PlayerState;

  factory PlayerState.fromJson(Map<String, dynamic> json) =>
      _$PlayerStateFromJson(json);

  static const minimumHighScore = 496;
}

enum AuthState {
  signedIn,
  loading,
  signedOut,
}

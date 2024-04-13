part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.currentGame,
    this.badgeSeries,
    this.life = 3,
    this.isCurrentGameWin = false,
    this.isMultiplayerUnlocked = false,
    this.latestScore = 0,
    this.highScore = 0,
    this.authState = AuthState.signedOut,
  });

  static const minimumHighScore = 496;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  final int life;
  final int latestScore;
  final int highScore;
  final int? badgeSeries;
  final bool isCurrentGameWin;
  final bool isMultiplayerUnlocked;
  final String? currentGame;
  final AuthState authState;

  PlayerState copyWith({
    int? life,
    int? latestScore,
    int? highScore,
    int? badgeSeries,
    String? currentGame,
    bool? isCurrentGameWin,
    bool? isMultiplayerUnlocked,
    AuthState? authState,
  }) =>
      PlayerState(
        life: life ?? this.life,
        latestScore: latestScore ?? this.latestScore,
        highScore: highScore ?? this.highScore,
        badgeSeries: badgeSeries ?? this.badgeSeries,
        currentGame: currentGame ?? this.currentGame,
        isCurrentGameWin: isCurrentGameWin ?? this.isCurrentGameWin,
        isMultiplayerUnlocked:
            isMultiplayerUnlocked ?? this.isMultiplayerUnlocked,
        authState: authState ?? this.authState,
      );

  @override
  List<Object?> get props => [
        life,
        latestScore,
        highScore,
        badgeSeries,
        currentGame,
        isCurrentGameWin,
        authState,
        isMultiplayerUnlocked,
      ];
}

enum AuthState {
  loading,
  signedIn,
  signedOut,
  unknown,
}

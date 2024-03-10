part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.currentGame,
    this.life = 3,
    this.isCurrentGameWin = false,
    this.isMultiplayerUnlocked = false,
    this.point = 0,
    this.isSignedIn = false,
  });

  User? get currentUser => FirebaseAuth.instance.currentUser;

  final int life;
  final int point;
  final bool isCurrentGameWin;
  final bool isMultiplayerUnlocked;
  final String? currentGame;
  final bool isSignedIn;

  PlayerState copyWith({
    int? life,
    int? point,
    String? currentGame,
    bool? isCurrentGameWin,
    bool? isMultiplayerUnlocked,
    bool? isSignedIn,
  }) =>
      PlayerState(
        life: life ?? this.life,
        point: point ?? this.point,
        currentGame: currentGame ?? this.currentGame,
        isCurrentGameWin: isCurrentGameWin ?? this.isCurrentGameWin,
        isMultiplayerUnlocked:
            isMultiplayerUnlocked ?? this.isMultiplayerUnlocked,
        isSignedIn: isSignedIn ?? this.isSignedIn,
      );

  @override
  List<Object?> get props => [
        life,
        point,
        currentGame,
        isCurrentGameWin,
        isSignedIn,
        isMultiplayerUnlocked,
      ];
}

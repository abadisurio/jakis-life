part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.currentGame,
    this.life = 3,
    this.isCurrentGameWin = false,
    this.isMultiplayerUnlocked = false,
    this.point = 0,
    this.currentPlayer,
  });

  User? get currentUser => FirebaseAuth.instance.currentUser;

  final int life;
  final int point;
  final bool isCurrentGameWin;
  final bool isMultiplayerUnlocked;
  final String? currentGame;
  final User? currentPlayer;

  PlayerState copyWith({
    int? life,
    int? point,
    String? currentGame,
    bool? isCurrentGameWin,
    bool? isMultiplayerUnlocked,
    User? currentPlayer,
  }) =>
      PlayerState(
        life: life ?? this.life,
        point: point ?? this.point,
        currentGame: currentGame ?? this.currentGame,
        isCurrentGameWin: isCurrentGameWin ?? this.isCurrentGameWin,
        isMultiplayerUnlocked:
            isMultiplayerUnlocked ?? this.isMultiplayerUnlocked,
        currentPlayer: currentPlayer ?? this.currentPlayer,
      );

  @override
  List<Object?> get props => [
        life,
        point,
        currentGame,
        isCurrentGameWin,
        currentPlayer,
        isMultiplayerUnlocked,
      ];
}

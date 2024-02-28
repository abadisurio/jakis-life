part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.currentGame,
    this.life = 3,
    this.point = 0,
  });

  final int life;
  final int point;
  final String? currentGame;

  PlayerState copyWith({
    int? life,
    int? point,
    String? currentGame,
  }) =>
      PlayerState(
        life: life ?? this.life,
        point: point ?? this.point,
        currentGame: currentGame ?? this.currentGame,
      );

  @override
  List<Object?> get props => [
        life,
        point,
        currentGame,
      ];
}

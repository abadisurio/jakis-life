part of 'commuter_rush_bloc.dart';

class CommuterRushState {
  const CommuterRushState({
    this.leftOffset = 0,
    this.rightOffset = 0,
    this.isWin,
  });

  final double leftOffset;
  final double rightOffset;
  final bool? isWin;

  CommuterRushState copyWith({
    double? leftOffset,
    double? rightOffset,
    bool? isWin,
  }) =>
      CommuterRushState(
        leftOffset: leftOffset ?? this.leftOffset,
        rightOffset: rightOffset ?? this.rightOffset,
        isWin: isWin ?? this.isWin,
      );
}

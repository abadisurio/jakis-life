part of 'commuter_rush_bloc.dart';

abstract class CommuterRushEvent {
  const CommuterRushEvent();
}

class SwipeLeftDoor extends CommuterRushEvent {
  const SwipeLeftDoor({required this.swipeOffset});

  final double swipeOffset;
}

class SwipeRightDoor extends CommuterRushEvent {
  const SwipeRightDoor({required this.swipeOffset});

  final double swipeOffset;
}

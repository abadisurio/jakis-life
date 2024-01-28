import 'package:bloc/bloc.dart';

part 'commuter_rush_event.dart';
part 'commuter_rush_state.dart';

class CommuterRushBloc extends Bloc<CommuterRushEvent, CommuterRushState> {
  CommuterRushBloc() : super(const CommuterRushState()) {
    on<SwipeLeftDoor>(_onSwipeLeftDoor);
    on<SwipeRightDoor>(_onSwipeRightDoor);
  }

  void _onSwipeLeftDoor(
    SwipeLeftDoor event,
    Emitter<CommuterRushState> emit,
  ) {
    emit(state.copyWith(leftOffset: event.swipeOffset));
  }

  void _onSwipeRightDoor(
    SwipeRightDoor event,
    Emitter<CommuterRushState> emit,
  ) {
    emit(state.copyWith(rightOffset: event.swipeOffset));
  }
}

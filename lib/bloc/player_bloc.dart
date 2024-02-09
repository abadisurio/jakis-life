import 'package:bloc/bloc.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<DecreaseLife>(_onDecreaseLife);
    on<ResetLife>(_onResetLife);
    on<UpdateCurrentGame>(_onUpdateCurrentGame);
  }

  void _onDecreaseLife(
    DecreaseLife event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(life: state.life - 1));
  }

  void _onResetLife(
    ResetLife event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(life: 3));
  }

  void _onUpdateCurrentGame(
    UpdateCurrentGame event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(currentGame: event.gameName));
  }
}

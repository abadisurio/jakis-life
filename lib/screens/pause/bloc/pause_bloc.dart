import 'package:bloc/bloc.dart';

part 'pause_event.dart';
part 'pause_state.dart';

class PauseBloc extends Bloc<PauseEvent, PauseState> {
  PauseBloc() : super(const PauseState()) {
    on<PauseGame>(_onPauseGame);
  }

  void _onPauseGame(
    PauseGame event,
    Emitter<PauseState> emit,
  ) {
    emit(state.copyWith(isPaused: event.isPaused));
  }
}

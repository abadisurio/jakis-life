import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'battery_parry_event.dart';
part 'battery_parry_state.dart';

class BatteryParryBloc extends Bloc<BatteryParryEvent, BatteryParryState> {
  BatteryParryBloc() : super(const BatteryParryState()) {
    on<EndGame>(_onLoseGame);
  }

  void _onLoseGame(
    EndGame event,
    Emitter<BatteryParryState> emit,
  ) {
    emit(state.copyWith(isWin: event.isWin));
  }
}

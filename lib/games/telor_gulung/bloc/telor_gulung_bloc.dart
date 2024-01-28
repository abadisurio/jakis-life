import 'package:bloc/bloc.dart';
part 'telor_gulung_event.dart';
part 'telor_gulung_state.dart';

class TelorGulungBloc extends Bloc<TelorGulungEvent, TelorGulungState> {
  TelorGulungBloc() : super(const TelorGulungState(weight: 1)) {
    on<AddWeight>(_onAddWeight);
    on<WeightLeft>(_onWeightLeft);
    on<WeightRight>(_onWeightRight);
  }

  void _onWeightLeft(
    WeightLeft event,
    Emitter<TelorGulungState> emit,
  ) {
    emit(state.copyWith(weight: state.weight - 0.7));
  }

  void _onWeightRight(
    WeightRight event,
    Emitter<TelorGulungState> emit,
  ) {
    emit(state.copyWith(weight: state.weight + 0.7, isWin: event.isWin));
  }

  void _onAddWeight(
    AddWeight event,
    Emitter<TelorGulungState> emit,
  ) {
    emit(state.copyWith(weight: state.weight * 1.02));
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'telor_gulung_event.dart';
part 'telor_gulung_state.dart';

class TelorGulungBloc extends Bloc<TelorGulungEvent, TelorGulungState> {
  TelorGulungBloc() : super(const TelorGulungState(weight: 1, progress: 0)) {
    on<AddWeight>(_onAddWeight);
    on<AddProgress>(_onAddProgress);
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

  void _onAddProgress(
    AddProgress event,
    Emitter<TelorGulungState> emit,
  ) {
    log('event.progress ${event.progress}');
    emit(state.copyWith(progress: event.progress));
  }
}

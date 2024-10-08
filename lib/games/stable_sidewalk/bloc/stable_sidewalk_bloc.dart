import 'dart:math' as math;

import 'package:bloc/bloc.dart';

part 'stable_sidewalk_event.dart';
part 'stable_sidewalk_state.dart';

class StableSidewalkBloc
    extends Bloc<StableSidewalkEvent, StableSidewalkState> {
  StableSidewalkBloc({
    required int level,
  })  : _level = level,
        super(
          StableSidewalkState(
            weight: math.Random().nextDouble() + level * 0.2,
          ),
        ) {
    on<AddWeight>(_onAddWeight);
    on<WeightLeft>(_onWeightLeft);
    on<WeightRight>(_onWeightRight);
  }

  final int _level;

  void _onWeightLeft(
    WeightLeft event,
    Emitter<StableSidewalkState> emit,
  ) {
    emit(state.copyWith(weight: state.weight - (2 + _level * 0.1)));
  }

  void _onWeightRight(
    WeightRight event,
    Emitter<StableSidewalkState> emit,
  ) {
    emit(state.copyWith(weight: state.weight + (2 + _level * 0.1)));
  }

  void _onAddWeight(
    AddWeight event,
    Emitter<StableSidewalkState> emit,
  ) {
    final isWin = state.weight.abs() * 3.14;
    emit(
      state.copyWith(
        weight: state.weight * 1.03,
        isWin: isWin >= 50 ? false : null,
      ),
    );
  }
}

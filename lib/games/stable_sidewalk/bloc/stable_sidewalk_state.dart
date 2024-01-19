part of 'stable_sidewalk_bloc.dart';

class StableSidewalkState {
  const StableSidewalkState({
    required this.weight,
    this.isWin,
  });
  final double weight;
  final bool? isWin;

  StableSidewalkState copyWith({double? weight, bool? isWin}) =>
      StableSidewalkState(
        weight: weight ?? this.weight,
        isWin: isWin ?? this.isWin,
      );
}

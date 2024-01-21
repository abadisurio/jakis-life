part of 'telor_gulung_bloc.dart';

class TelorGulungState {
  const TelorGulungState({
    required this.weight,
    this.isWin,
  });
  final double weight;
  final bool? isWin;

  TelorGulungState copyWith({double? weight, bool? isWin}) => TelorGulungState(
        weight: weight ?? this.weight,
        isWin: isWin ?? this.isWin,
      );
}

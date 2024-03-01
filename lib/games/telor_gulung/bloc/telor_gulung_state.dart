part of 'telor_gulung_bloc.dart';

class TelorGulungState extends Equatable {
  const TelorGulungState({
    required this.weight,
    required this.progress,
    this.isWin,
  });
  final double weight;
  final double progress;
  final bool? isWin;

  TelorGulungState copyWith({
    double? weight,
    double? progress,
    bool? isWin,
  }) =>
      TelorGulungState(
        weight: weight ?? this.weight,
        progress: progress ?? this.progress,
        isWin: isWin ?? this.isWin,
      );

  @override
  List<Object?> get props => [weight, progress, isWin];
}

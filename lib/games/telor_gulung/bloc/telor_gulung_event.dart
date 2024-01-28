part of 'telor_gulung_bloc.dart';

sealed class TelorGulungEvent {
  const TelorGulungEvent();
}

class AddWeight extends TelorGulungEvent {}

class WeightLeft extends TelorGulungEvent {}

class WeightRight extends TelorGulungEvent {
  const WeightRight({
    this.isWin,
  });

  final bool? isWin;
}

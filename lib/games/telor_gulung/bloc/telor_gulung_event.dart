part of 'telor_gulung_bloc.dart';

sealed class TelorGulungEvent {}

class AddWeight extends TelorGulungEvent {}

class WeightLeft extends TelorGulungEvent {}

class WeightRight extends TelorGulungEvent {}

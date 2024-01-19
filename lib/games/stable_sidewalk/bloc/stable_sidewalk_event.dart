part of 'stable_sidewalk_bloc.dart';

sealed class StableSidewalkEvent {}

class AddWeight extends StableSidewalkEvent {}

class WeightLeft extends StableSidewalkEvent {}

class WeightRight extends StableSidewalkEvent {}

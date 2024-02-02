part of 'litter_picker_bloc.dart';

class LitterPickerEvent {
  const LitterPickerEvent();
}

class LitterPickerInitial extends LitterPickerEvent {}

class PickLitter extends LitterPickerEvent {
  const PickLitter({
    required this.litterIndex,
  });

  final int litterIndex;
}

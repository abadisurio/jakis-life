part of 'litter_picker_bloc.dart';

class LitterPickerState {
  const LitterPickerState({
    required this.litterCount,
    required this.litterPickedCount,
    this.litterPicked,
  });

  final int litterCount;
  final int litterPickedCount;
  final int? litterPicked;

  LitterPickerState copyWith({
    int? litterCount,
    int? litterPickedCount,
    int? litterPicked,
  }) =>
      LitterPickerState(
        litterCount: litterCount ?? this.litterCount,
        litterPickedCount: litterPickedCount ?? this.litterPickedCount,
        litterPicked: litterPicked ?? this.litterPicked,
      );
}

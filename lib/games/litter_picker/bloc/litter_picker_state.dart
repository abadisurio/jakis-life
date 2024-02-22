part of 'litter_picker_bloc.dart';

class LitterPickerState {
  const LitterPickerState({
    required this.litterCount,
    required this.organicCount,
    required this.litterPickedCount,
    this.litterPicked,
  });

  final int litterCount;
  final int organicCount;
  final int litterPickedCount;
  final int? litterPicked;

  LitterPickerState copyWith({
    int? litterCount,
    int? organicCount,
    int? litterPickedCount,
    int? litterPicked,
  }) =>
      LitterPickerState(
        litterCount: litterCount ?? this.litterCount,
        organicCount: organicCount ?? this.organicCount,
        litterPickedCount: litterPickedCount ?? this.litterPickedCount,
        litterPicked: litterPicked ?? this.litterPicked,
      );
}

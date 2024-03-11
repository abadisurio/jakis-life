part of 'battery_parry_bloc.dart';

class BatteryParryState {
  const BatteryParryState({
    this.isWin,
  });

  final bool? isWin;

  BatteryParryState copyWith({
    bool? isWin,
  }) {
    return BatteryParryState(
      isWin: isWin ?? this.isWin,
    );
  }
}

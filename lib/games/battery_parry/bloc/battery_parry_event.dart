part of 'battery_parry_bloc.dart';

class BatteryParryEvent {
  const BatteryParryEvent();
}

class EndGame extends BatteryParryEvent {
  const EndGame({required this.isWin});

  final bool isWin;
}

part of 'app_bloc.dart';

class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class ToggleBacksoundPlayPause extends AppEvent {
  const ToggleBacksoundPlayPause({this.isPaused});

  final bool? isPaused;
}

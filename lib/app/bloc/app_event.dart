part of 'app_bloc.dart';

class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInitialize extends AppEvent {
  const AppInitialize();
}

class AppLinkUpdateQuery extends AppEvent {
  const AppLinkUpdateQuery({this.query});

  final Map<String, String>? query;
}

class ToggleBacksoundPlayPause extends AppEvent {
  const ToggleBacksoundPlayPause({this.isPaused});

  final bool? isPaused;
}

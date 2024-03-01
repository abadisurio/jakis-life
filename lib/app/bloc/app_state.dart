part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.isBacksoundPaused = false,
  });

  final bool isBacksoundPaused;

  AppState copyWith({
    bool? isBacksoundPaused,
  }) =>
      AppState(
        isBacksoundPaused: isBacksoundPaused ?? this.isBacksoundPaused,
      );

  @override
  List<Object> get props => [isBacksoundPaused];
}

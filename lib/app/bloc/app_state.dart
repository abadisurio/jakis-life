part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.isBacksoundPaused = false,
    this.appLinkQuery,
  });

  final bool isBacksoundPaused;
  final Map<String, String>? appLinkQuery;

  AppState copyWith({
    bool? isBacksoundPaused,
    Map<String, String>? appLinkQuery,
  }) =>
      AppState(
        isBacksoundPaused: isBacksoundPaused ?? this.isBacksoundPaused,
        appLinkQuery: appLinkQuery ?? {},
      );

  @override
  List<Object?> get props => [
        isBacksoundPaused,
        appLinkQuery,
      ];
}

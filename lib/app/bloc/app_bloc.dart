import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jakislife/gen/assets.gen.dart';

part 'app_event.dart';
part 'app_state.dart';

final _appLinks = AppLinks();

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<ToggleBacksoundPlayPause>(_onToggleBacksoundPlayPause);
    on<AppInitialize>(_onAppInitialize);
    on<AppLinkUpdateQuery>(_onAppUpdateAppLink);
  }
  final _audioPlayer = AudioPlayer(playerId: 'jakis_theme');
  late StreamSubscription<dynamic> _linkSubscription;

  Future<void> _startBacksound() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(
      AssetSource(Assets.sounds.jakisTheme),
    );
  }

  Future<void> _initializeAppLink() async {
    final initialUri = await _appLinks.getInitialAppLink();
    add(AppLinkUpdateQuery(query: initialUri?.queryParameters));
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      add(const AppLinkUpdateQuery(query: {}));
      add(AppLinkUpdateQuery(query: uri.queryParameters));
    });
  }

  void _onAppInitialize(
    AppInitialize event,
    Emitter<AppState> emit,
  ) {
    _initializeAppLink();
    _startBacksound();
  }

  Future<void> _onAppUpdateAppLink(
    AppLinkUpdateQuery event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(appLinkQuery: event.query));
  }

  Future<void> _onToggleBacksoundPlayPause(
    ToggleBacksoundPlayPause event,
    Emitter<AppState> emit,
  ) async {
    if (!state.isBacksoundPaused) {
      if (_audioPlayer.state == PlayerState.playing) {
        await _audioPlayer.pause();
      }
    } else {
      await _audioPlayer.resume();
    }
    emit(
      state.copyWith(
        isBacksoundPaused: event.isPaused ?? !state.isBacksoundPaused,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _linkSubscription.cancel();
    return super.close();
  }
}

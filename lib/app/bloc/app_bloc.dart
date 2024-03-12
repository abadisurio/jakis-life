import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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

  // Future<void> _startBacksound() async {
  //   await _audioPlayer.setReleaseMode(ReleaseMode.loop);
  //   await _audioPlayer.play(
  //     AssetSource(Assets.sounds.jakisTheme),
  //   );
  // }

  Future<void> _initializeAppLink() async {
    // String host = Platform.isAndroid ? 'https://127.0.0.1:5001' : 'localhost';
    final initialUri = await _appLinks.getInitialAppLink();
    log('uri1 $initialUri');
    add(AppLinkUpdateQuery(query: initialUri?.queryParameters));
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      add(const AppLinkUpdateQuery(query: {}));
      log('uri2 ${uri.queryParameters['start-multiplayer']}');
      add(AppLinkUpdateQuery(query: uri.queryParameters));
      // final response = await FirebaseFunctions.instance
      //     .httpsCallable('createMultiplayer')
      //     .call<Map<String, dynamic>>(
      //   {
      //     'inviterId': '22',
      //     'invitedId': '99',
      //   },
      // );
      // log('response $response');
      // Do something (navigation, ...)
    });
  }

  void _onAppInitialize(
    AppInitialize event,
    Emitter<AppState> emit,
  ) {
    _initializeAppLink();
  }

  Future<void> _onAppUpdateAppLink(
    AppLinkUpdateQuery event,
    Emitter<AppState> emit,
  ) async {
    log('event.query ${event.query}');
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

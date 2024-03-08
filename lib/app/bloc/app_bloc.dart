import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jakislife/flutter_notifications.dart';

part 'app_event.dart';
part 'app_state.dart';

final _appLinks = AppLinks();

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<ToggleBacksoundPlayPause>(_onToggleBacksoundPlayPause);
    _initialize();
  }
  final _audioPlayer = AudioPlayer(playerId: 'jakis_theme');
  late StreamSubscription<dynamic> _linkSubscription;
  void _initialize() {
    // _startBacksound();
    _getAppLink();
    _setupNotification();
  }

  // Future<void> _startBacksound() async {
  //   await _audioPlayer.setReleaseMode(ReleaseMode.loop);
  //   await _audioPlayer.play(
  //     AssetSource(Assets.sounds.jakisTheme),
  //   );
  // }

  Future<void> _getAppLink() async {
    // final uri = await _appLinks.getInitialAppLink();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      log('uri $uri');
      // Do something (navigation, ...)
    });
  }

  Future<void> _setupNotification() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    log('initialMessage $initialMessage');

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('message $message');
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
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

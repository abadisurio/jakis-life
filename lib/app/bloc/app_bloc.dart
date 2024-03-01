import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jakislife/gen/assets.gen.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<ToggleBacksoundPlayPause>(_onToggleBacksoundPlayPause);
    _initialize();
  }
  final _audioPlayer = AudioPlayer(playerId: 'jakis_theme');

  void _initialize() {
    _startBacksound();
  }

  Future<void> _startBacksound() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(
      AssetSource(Assets.sounds.jakisTheme),
    );
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
}

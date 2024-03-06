import 'dart:developer';
import 'dart:math' show Random;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jakislife/model/model.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlayerSignIn>(_onPlayerSignIn);
    on<IncreasePoint>(_onIncreasePoint);
    on<DecreaseLife>(_onDecreaseLife);
    on<ResetLife>(_onResetLife);
    on<UpdateCurrentGame>(_onUpdateCurrentGame);
    on<UpdateCurrentGameWin>(_onUpdateCurrentGameWin);
  }

  // static const _storage = FlutterSecureStorage();

  void _onIncreasePoint(
    IncreasePoint event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(point: state.point + Random().nextInt(80) + 50));
  }

  void _onDecreaseLife(
    DecreaseLife event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(life: state.life - 1));
  }

  void _onResetLife(
    ResetLife event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(life: 3, point: 0));
  }

  void _onUpdateCurrentGame(
    UpdateCurrentGame event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(currentGame: event.gameName));
  }

  void _onUpdateCurrentGameWin(
    UpdateCurrentGameWin event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(isCurrentGameWin: event.isWin));
  }

  Future<void> _onPlayerSignIn(
    PlayerSignIn event,
    Emitter<PlayerState> emit,
  ) async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCred.user != null) {
      final uss = JakisLifeUser(id: userCred.user!.uid, score: 0);
      log('uss ${uss.toJson()}');
      // _storage.write(key: 'stored_user_google', value: value)
    }
  }
}

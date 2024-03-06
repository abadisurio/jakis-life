import 'dart:convert';
import 'dart:developer';

import 'dart:math' show Random;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlayerSignIn>(_onPlayerSignIn);
    on<PlayerSignOut>(_onPlayerSignOut);
    on<IncreasePoint>(_onIncreasePoint);
    on<DecreaseLife>(_onDecreaseLife);
    on<ResetLife>(_onResetLife);
    on<UpdateCurrentGame>(_onUpdateCurrentGame);
    on<UpdateCurrentGameWin>(_onUpdateCurrentGameWin);
    _initialize();
  }

  static const _keyStorageUserGoogle = 'stored_user_google';

  OAuthCredential? _currentCredential;

  Future<void> _initialize() async {
    final credential = await _storage.read(
      key: _keyStorageUserGoogle,
      aOptions: _secureStorageAndroidOptions,
    );
    log('credential $credential');
    if (credential != null) {
      final credentialJson = json.decode(credential) as Map;
      final providerId = credentialJson['providerId'] as String?;
      final signInMethod = credentialJson['signInMethod'] as String?;
      final accessToken = credentialJson['accessToken'] as String?;
      if (providerId != null && signInMethod != null && accessToken != null) {
        _currentCredential = OAuthCredential(
          providerId: providerId,
          signInMethod: signInMethod,
          accessToken: accessToken,
        );
        add(const PlayerSignIn());
      }
    }
  }

  static const _storage = FlutterSecureStorage();
  static const _secureStorageAndroidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
    // sharedPreferencesName: 'Test2',
    // preferencesKeyPrefix: 'Test'
  );

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
    late OAuthCredential credential;
    if (_currentCredential == null) {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        // Create a new credential
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _storage.write(
          key: _keyStorageUserGoogle,
          value: json.encode(credential.asMap()),
          aOptions: _secureStorageAndroidOptions,
        );
      }
    } else {
      credential = _currentCredential!;
    }
    await FirebaseAuth.instance.signInWithCredential(credential);
    emit(state.copyWith(isSignedIn: true));
  }

  Future<void> _onPlayerSignOut(
    PlayerSignOut event,
    Emitter<PlayerState> emit,
  ) async {
    await FirebaseAuth.instance.signOut();
    await _storage.delete(
      key: _keyStorageUserGoogle,
      aOptions: _secureStorageAndroidOptions,
    );
    emit(state.copyWith(isSignedIn: false));
  }
}

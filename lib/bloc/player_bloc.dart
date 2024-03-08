import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'dart:math' show Random;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jakislife/model/model.dart';

part 'player_event.dart';
part 'player_state.dart';

final _googleSignIn = GoogleSignIn();

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlayerInitialize>(_onPlayerInitialize);
    on<PlayerSignIn>(_onPlayerSignIn);
    on<PlayerSignOut>(_onPlayerSignOut);
    on<IncreasePoint>(_onIncreasePoint);
    on<DecreaseLife>(_onDecreaseLife);
    on<ResetLife>(_onResetLife);
    on<UpdateCurrentGame>(_onUpdateCurrentGame);
    on<UpdateCurrentGameWin>(_onUpdateCurrentGameWin);
  }

  static const _keyStoredUserGoogle = 'stored_user_google';
  static const _keyStoredUserJakisLife = 'stored_user_jakislife';

  static const _storage = FlutterSecureStorage();
  static const _secureStorageAndroidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );
  OAuthCredential? _currentCredential;
  // JakisLifePlayer? _jakisLifePlayer;

  Future<void> _initialize() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      final credential = await _storage.read(
        key: _keyStoredUserGoogle,
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
  }

  Future<JakisLifePlayer?> _updateJakisLifePlayer() async {
    final stringJakisLifePlayer = await _storage.read(
      key: _keyStoredUserJakisLife,
      aOptions: _secureStorageAndroidOptions,
    );
    final localJakislifePlayer = stringJakisLifePlayer == null
        ? null
        : JakisLifePlayer.fromJson(
            json.decode(stringJakisLifePlayer) as Map<String, dynamic>,
          );

    final currentUser = FirebaseAuth.instance.currentUser;
    final col = FirebaseFirestore.instance.collection('players');
    final doc = col.doc(currentUser?.uid);
    late JakisLifePlayer jakisLifePlayer;

    Future<void> writeToFirestore(JakisLifePlayer jakisLifePlayer) async {
      await doc.set(
        jakisLifePlayer.toJson()..remove('id'),
        SetOptions(merge: true),
      );
    }

    Future<void> createNewPlayer() async {
      const playerId = 'jakislife';
      jakisLifePlayer = JakisLifePlayer(
        id: playerId,
        score: 0,
      );
      await _storage.write(
        key: _keyStoredUserJakisLife,
        value: json.encode(jakisLifePlayer.toJson()),
        aOptions: _secureStorageAndroidOptions,
      );
    }

    log('stringJakisLifePlayer $stringJakisLifePlayer');
    log('currentUser $currentUser');
    if (currentUser == null && localJakislifePlayer == null) {
      await createNewPlayer();
    }
    if (currentUser == null && localJakislifePlayer != null) {
      jakisLifePlayer = localJakislifePlayer;
    }

    if (currentUser != null && localJakislifePlayer == null) {
      final doc = col.doc(currentUser.uid);
      final snapshot = await doc.get();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (snapshot.exists) {
        jakisLifePlayer = JakisLifePlayer.fromJson({
          'id': currentUser.uid,
          'fcmToken': fcmToken,
          ...snapshot.data() ?? {},
        });
      } else {
        await createNewPlayer();
      }
    }

    if (currentUser != null && localJakislifePlayer != null) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      jakisLifePlayer = localJakislifePlayer.copyWith(fcmToken: fcmToken);
      await writeToFirestore(jakisLifePlayer);
    }

    // if (stringJakisLifePlayer == null) {
    //   final snapshot = await doc.get();
    //   if (snapshot.exists) {
    //     jakisLifePlayer = JakisLifePlayer.fromJson({
    //       'id': currentUser?.uid,
    //       ...snapshot.data() ?? {},
    //     });
    //   } else {
    //     const playerId = 'jakislife';
    //     final fcmToken = await FirebaseMessaging.instance.getToken();
    //     // if (stringJakisLifePlayer == null) return null;
    //     jakisLifePlayer = JakisLifePlayer(
    //       id: playerId,
    //       score: 0,
    //       fcmToken: fcmToken,
    //     );
    //     unawaited(
    //       Future(() async {
    //         await doc.set(
    //           jakisLifePlayer.toJson()..remove('id'),
    //           SetOptions(merge: true),
    //         );

    //         await _storage.write(
    //           key: _keyStoredUserJakisLife,
    //           value: json.encode(jakisLifePlayer.toJson()),
    //           aOptions: _secureStorageAndroidOptions,
    //         );
    //       }),
    //     );
    //   }
    // } else {
    //   jakisLifePlayer = JakisLifePlayer.fromJson(
    //     json.decode(stringJakisLifePlayer) as Map<String, dynamic>,
    //   );
    // }

    log('jakisLifePlayer $jakisLifePlayer');
    return jakisLifePlayer;
  }

  Future<void> _onPlayerInitialize(
    PlayerInitialize event,
    Emitter<PlayerState> emit,
  ) async {
    await _initialize();
    final player = await _updateJakisLifePlayer();
    emit(
      state.copyWith(
        point: player?.score,
        isSignedIn: FirebaseAuth.instance.currentUser != null,
      ),
    );
  }

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

      final googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        // Create a new credential
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _storage.write(
          key: _keyStoredUserGoogle,
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
    await _googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();

    await _storage.delete(
      key: _keyStoredUserGoogle,
      aOptions: _secureStorageAndroidOptions,
    );
    emit(state.copyWith(isSignedIn: false));
  }
}

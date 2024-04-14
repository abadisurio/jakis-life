import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jakislife/model/model.dart';

part 'player_event.dart';
part 'player_state.dart';
part 'player_bloc.freezed.dart';
part 'player_bloc.g.dart';

final _googleSignIn = GoogleSignIn();

class PlayerBloc extends HydratedBloc<PlayerEvent, PlayerState> {
  PlayerBloc({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
        super(const PlayerState()) {
    _userCol = firebaseFirestore.collection('players');
    on<PlayerInitialize>(_onPlayerInitialize);
    on<RefreshPlayer>(_onRefreshPlayer);
    on<PlayerSignIn>(_onPlayerSignIn);
    on<PlayerSignOut>(_onPlayerSignOut);
    on<IncreasePoint>(_onIncreasePoint);
    on<DecreaseLife>(_onDecreaseLife);
    on<ResetLife>(_onResetLife);
    on<UpdateCurrentGame>(_onUpdateCurrentGame);
    on<UpdateCurrentGameWin>(_onUpdateCurrentGameWin);
    on<EarnBadge>(_onEarnBadge);

    _curentUser = FirebaseAuth.instance.currentUser;
    _userDoc = _userCol.doc(_curentUser?.uid);
  }

  static const _keyStoredUserGoogle = 'stored_user_google';
  static const _keyStoredUserJakisLife = 'stored_user_jakislife';

  static const _storage = FlutterSecureStorage();
  static const _secureStorageAndroidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );
  OAuthCredential? _currentCredential;

  JakisLifePlayer? _remotePlayer;
  JakisLifePlayer? _localPlayer;
  JakisLifePlayer? _currentJakisLifePlayer;
  User? _curentUser;
  bool? _overrideFromFirestore;
  late DocumentReference _userDoc;
  late CollectionReference _userCol;

  final FirebaseAuth _firebaseAuth;

  Future<void> _initialize() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      final credential = await _storage.read(
        key: _keyStoredUserGoogle,
        aOptions: _secureStorageAndroidOptions,
      );
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

  Future<void> _initializePlayer() async {
    // _localPlayer = await _readFromStorage();
    _remotePlayer = await _readFromFirestore();

    final player =
        (_overrideFromFirestore ?? false) ? _remotePlayer : _localPlayer;
    _currentJakisLifePlayer = player ?? await _createNewPlayer();
    await _updateJakisLifePlayer();

    await _writeToFirestore(_currentJakisLifePlayer!);
  }

  Future<JakisLifePlayer?> _readFromFirestore() async {
    final snapshot = await _userDoc.get();
    final remoteData = snapshot.data() as Map<String, dynamic>?;
    if (snapshot.exists) {
      _overrideFromFirestore = remoteData?['overrideFromFirestore'] as bool?;
      return JakisLifePlayer.fromJson({
        'id': _userDoc.id,
        ...remoteData ?? {},
      });
    }
    return null;
  }

  Future<void> _writeToFirestore(JakisLifePlayer jakisLifePlayer) async {
    await _userDoc.set(
      jakisLifePlayer.toJson()..remove('id'),
      SetOptions(merge: true),
    );
  }

  // Future<void> _writeToStorage(JakisLifePlayer jakisLifePlayer) async {
  //   await _storage.write(
  //     key: _keyStoredUserJakisLife,
  //     value: json.encode(jakisLifePlayer.toJson()),
  //     aOptions: _secureStorageAndroidOptions,
  //   );
  // }

  // Future<JakisLifePlayer?> _readFromStorage() async {
  //   final stringJakisLifePlayer = await _storage.read(
  //     key: _keyStoredUserJakisLife,
  //     aOptions: _secureStorageAndroidOptions,
  //   );
  //   if (stringJakisLifePlayer != null) {
  //     return JakisLifePlayer.fromJson(
  //       json.decode(stringJakisLifePlayer) as Map<String, dynamic>,
  //     );
  //   }
  //   return null;
  // }

  Future<JakisLifePlayer> _createNewPlayer() async {
    const playerId = 'jakislife';
    return JakisLifePlayer(
      id: playerId,
      highScore: 0,
    );
  }

  Future<JakisLifePlayer?> _updateJakisLifePlayer({
    JakisLifePlayer? newJakisLifePlayer,
  }) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (newJakisLifePlayer != null) {
      _currentJakisLifePlayer = newJakisLifePlayer;
    }
    if (_curentUser != null) {
      _currentJakisLifePlayer = _currentJakisLifePlayer!.copyWith(
        fcmToken: fcmToken,
        photoUrl: _curentUser?.photoURL,
        displayName: _curentUser?.displayName,
      );
    }

    // unawaited(_writeToStorage(_currentJakisLifePlayer!));
    unawaited(_writeToFirestore(_currentJakisLifePlayer!));

    return _currentJakisLifePlayer;
  }

  Future<void> _onPlayerInitialize(
    PlayerInitialize event,
    Emitter<PlayerState> emit,
  ) async {
    await _initializeLocalCredential();
    // log('_currentCredential $_currentCredential');
    if (_currentCredential != null) {
      await _initializeUserData();
      emit(
        state.copyWith(
          authState: AuthState.signedIn,
          user: _currentJakisLifePlayer,
        ),
      );
    } else {
      emit(state.copyWith(authState: AuthState.signedOut));
    }

    await _initialize();
    await _initializePlayer();
    emit(
      state.copyWith(
        highScore: _currentJakisLifePlayer?.highScore ?? 0,
        badgeSeries: _currentJakisLifePlayer?.badgeSeries,
        isMultiplayerUnlocked: (_currentJakisLifePlayer?.highScore ?? 0) >=
            PlayerState.minimumHighScore,
        authState: FirebaseAuth.instance.currentUser != null
            ? AuthState.signedIn
            : AuthState.signedOut,
      ),
    );
  }

  Future<void> _initializeLocalCredential() async {
    final credential = await _storage.read(
      key: _keyStoredUserGoogle,
      aOptions: _secureStorageAndroidOptions,
    );
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
        // add(const UserInitialize());
      }
    }

    // if (currentUser == null) {
    // }
  }

  Future<void> _initializeUserData() async {
    _curentUser = _firebaseAuth.currentUser;
    _userDoc = _userCol.doc(_curentUser!.uid);

    // _localUser = await _readFromStorage();
    _remotePlayer = await _readFromFirestore();

    // log('_localUser $_localUser');
    log('_localUser ${state.user}');
    log('_remotePlayer $_remotePlayer');
    final user = _remotePlayer ?? state.user;
    if (state.user != null && _remotePlayer == null) {
      await _createNewUserToFirestore();
    }
    if (state.user == null && _remotePlayer != null) {
      await _readFromFirestore();
    }
    _currentJakisLifePlayer = user ?? await _createNewUserToFirestore();
    log('_currentJakisLifePlayer2 $_currentJakisLifePlayer');
    // add(const RefreshPlayer());
  }

  Future<JakisLifePlayer> _createNewUserToFirestore() async {
    final id = _firebaseAuth.currentUser!.uid;
    final newJakisLifePlayer = JakisLifePlayer(
      id: id,
      displayName: _firebaseAuth.currentUser?.displayName,
      photoUrl: _firebaseAuth.currentUser?.photoURL,
    );
    await _writeToFirestore(newJakisLifePlayer);
    return newJakisLifePlayer;
  }

  void _onIncreasePoint(
    IncreasePoint event,
    Emitter<PlayerState> emit,
  ) {
    emit(
      state.copyWith(
        latestScore: state.latestScore + Random().nextInt(80) + 50,
      ),
    );
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
    if (state.latestScore > state.highScore) {
      _updateJakisLifePlayer(
        newJakisLifePlayer: _currentJakisLifePlayer?.copyWith(
          highScore: state.latestScore,
        ),
      );
      emit(
        state.copyWith(
          life: 3,
          latestScore: 0,
          highScore: state.latestScore,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        life: 3,
        latestScore: 0,
      ),
    );
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
    emit(state.copyWith(authState: AuthState.loading));
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

    await _initializePlayer();

    emit(state.copyWith(authState: AuthState.signedIn));
  }

  Future<void> _onEarnBadge(
    EarnBadge event,
    Emitter<PlayerState> emit,
  ) async {
    final badgeSeries = Random().nextInt(3);
    emit(state.copyWith(badgeSeries: badgeSeries));
    await _updateJakisLifePlayer(
      newJakisLifePlayer: _currentJakisLifePlayer?.copyWith(
        badgeSeries: badgeSeries,
      ),
    );
    add(const PlayerInitialize());
  }

  Future<void> _onPlayerSignOut(
    PlayerSignOut event,
    Emitter<PlayerState> emit,
  ) async {
    emit(state.copyWith(authState: AuthState.loading));
    await _googleSignIn.disconnect();
    await _firebaseAuth.signOut();

    await _storage.delete(
      key: _keyStoredUserJakisLife,
      aOptions: _secureStorageAndroidOptions,
    );

    await _storage.delete(
      key: _keyStoredUserGoogle,
      aOptions: _secureStorageAndroidOptions,
    );
    emit(state.copyWith(authState: AuthState.signedOut));
  }

  @override
  PlayerState? fromJson(Map<String, dynamic> json) {
    return PlayerState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PlayerState state) {
    return state.toJson();
  }

  Future<void> _onRefreshPlayer(
    RefreshPlayer event,
    Emitter<PlayerState> emit,
  ) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (event.newPlayer != null) {
      _currentJakisLifePlayer = event.newPlayer;
    }
    if ((_curentUser != null &&
            _currentJakisLifePlayer != null &&
            fcmToken != null) &&
        fcmToken != _currentJakisLifePlayer!.fcmToken) {
      _currentJakisLifePlayer = _currentJakisLifePlayer!.copyWith(
        fcmToken: fcmToken,
        photoUrl: _curentUser?.photoURL,
      );

      unawaited(_writeToFirestore(_currentJakisLifePlayer!));

      emit(state.copyWith(user: _currentJakisLifePlayer));
    }
  }
}

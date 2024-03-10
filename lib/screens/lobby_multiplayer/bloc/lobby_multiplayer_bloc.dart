import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'lobby_multiplayer_event.dart';
part 'lobby_multiplayer_state.dart';

class LobbyMultiplayerBloc
    extends Bloc<LobbyMultiplayerEvent, LobbyMultiplayerState> {
  LobbyMultiplayerBloc() : super(const LobbyMultiplayerState()) {
    on<StartMultiplayerSession>(_onStartMultiplayerSession);
    on<StandbyGame>(_onStandbyGame);
    on<UpdateScore>(_onUpdateScore);
    on<UpdateState>(_onUpdateState);
    on<UpdatePlayerData>(_onUpdatePlayerData);
  }

  Future<void> _onStartMultiplayerSession(
    StartMultiplayerSession event,
    Emitter<LobbyMultiplayerState> emit,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      final response = await FirebaseFunctions.instance
          .httpsCallable('createMultiplayer')
          .call<Map<String, dynamic>>(
        {
          'inviterId': currentUser?.uid,
          'invitedId': event.invitedId,
        },
      );
      log('response ${response.data}');
      final challengeId = response.data['challengeId'] as String?;
      emit(state.copyWith(challengeId: challengeId));
      final docRef = FirebaseFirestore.instance
          .collection('challenges')
          // .doc(state.challengeId);
          .doc('y9GM96CtfRsyRASax5wW');
      docRef.snapshots().listen((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data();
          log('data $data');
        }
      });
    } catch (e) {
      log('eee $e');
    }
  }

  Future<void> _onStandbyGame(
    StandbyGame event,
    Emitter<LobbyMultiplayerState> emit,
  ) async {
    add(const UpdateState(playersState: PlayersState.standby));
  }

  Future<void> _onUpdateState(
    UpdateState event,
    Emitter<LobbyMultiplayerState> emit,
  ) async {
    add(UpdatePlayerData(playersState: event.playersState));
  }

  Future<void> _onUpdateScore(
    UpdateScore event,
    Emitter<LobbyMultiplayerState> emit,
  ) async {
    add(UpdatePlayerData(playersScore: event.score));
  }

  Future<void> _onUpdatePlayerData(
    UpdatePlayerData event,
    Emitter<LobbyMultiplayerState> emit,
  ) async {
    // if (state.challengeId == null) {
    //   return;
    // }
    final currentUser = FirebaseAuth.instance.currentUser!;
    final docRef = FirebaseFirestore.instance
        .collection('challenges')
        // .doc(state.challengeId);
        .doc('y9GM96CtfRsyRASax5wW');

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) return;

      final playersScore = data['playersScore'] as Map<String, dynamic>?;
      if (event.playersScore != null) {
        await playersScore?.update(
          currentUser.uid,
          (value) => event.playersScore,
        );
      }

      final playersState = data['playersState'] as Map<String, dynamic>?;
      if (event.playersState != null) {
        await playersState?.update(
          currentUser.uid,
          (value) => event.playersState,
        );
      }

      await docRef.set(
        {
          'playersScore': playersScore,
          'playersState': playersState,
        },
        SetOptions(merge: true),
      );
    }
    //
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'multiplayer_event.dart';
part 'multiplayer_state.dart';

class MultiplayerBloc extends Bloc<MultiplayerEvent, MultiplayerState> {
  MultiplayerBloc() : super(const MultiplayerState()) {
    on<StartMultiplayerSession>(_onStartMultiplayerSession);
    on<StandbyGame>(_onStandbyGame);
    on<UpdateScore>(_onUpdateScore);
    on<UpdateState>(_onUpdateState);
    on<UpdateRemotePlayerData>(_onUpdateRemotePlayerData);
  }

  Future<void> _onStartMultiplayerSession(
    StartMultiplayerSession event,
    Emitter<MultiplayerState> emit,
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
      // log('response ${response.data}');
      final challengeId = response.data['challengeId'] as String?;
      emit(state.copyWith(challengeId: challengeId));
      final docRef =
          FirebaseFirestore.instance.collection('challenges').doc(challengeId);
      // .doc('CZExHdv58WW8kAHyEpV7');
      docRef.snapshots().listen((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data();
          log('data123 $data');
        }
      });
    } catch (e) {
      log('eee $e');
    }
  }

  Future<void> _onStandbyGame(
    StandbyGame event,
    Emitter<MultiplayerState> emit,
  ) async {
    add(const UpdateState(playersState: PlayersState.standby));
  }

  Future<void> _onUpdateState(
    UpdateState event,
    Emitter<MultiplayerState> emit,
  ) async {
    add(UpdateRemotePlayerData(playersState: event.playersState));
  }

  Future<void> _onUpdateScore(
    UpdateScore event,
    Emitter<MultiplayerState> emit,
  ) async {
    add(UpdateRemotePlayerData(playersScore: event.score));
  }

  Future<void> _onUpdateRemotePlayerData(
    UpdateRemotePlayerData event,
    Emitter<MultiplayerState> emit,
  ) async {
    if (state.challengeId == null) {
      return;
    }
    final currentUser = FirebaseAuth.instance.currentUser!;
    final docRef = FirebaseFirestore.instance
        .collection('challenges')
        .doc(state.challengeId);
    // .doc('CZExHdv58WW8kAHyEpV7');

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

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jakislife/model/model.dart';

part 'multiplayer_event.dart';
part 'multiplayer_state.dart';

class MultiplayerBloc extends Bloc<MultiplayerEvent, MultiplayerState> {
  MultiplayerBloc() : super(const MultiplayerState()) {
    on<StartMultiplayerSession>(_onStartMultiplayerSession);
    on<UpdatePlayers>(_onUpdatePlayers);
    on<StandbyGame>(_onStandbyGame);
    on<UpdateScore>(_onUpdateScore);
    on<UpdateState>(_onUpdateState);
    on<UpdatePlayerData>(_onUpdatePlayerData);
  }

  DocumentReference? _challengeRef;

  Future<void> _onStartMultiplayerSession(
    StartMultiplayerSession event,
    Emitter<MultiplayerState> emit,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final selfId = currentUser!.uid;
    late String opponentId;
    late String challengeId;

    if (event.invitedId != null) {
      try {
        final response = await FirebaseFunctions.instance
            .httpsCallable('createMultiplayer')
            .call<Map<String, dynamic>>(
          {
            'inviterId': selfId,
            'invitedId': event.invitedId,
          },
        );
        log('response ${response.data}');
        final remoteChallengeId =
            (response.data['data'] as Map)['challengeId'] as String?;
        // final inviterId = response.data['inviterId'] as String?;
        _challengeRef = FirebaseFirestore.instance
            .collection('challenges')
            .doc(remoteChallengeId);
        opponentId = event.invitedId!;

        challengeId = remoteChallengeId!;
      } catch (e) {
        log('eee $e');
      }
    } else if (event.challengeId != null) {
      _challengeRef = FirebaseFirestore.instance
          .collection('challenges')
          .doc(event.challengeId);
      final challengeSnapshot = await _challengeRef?.get();
      final remoteOpponentId = (challengeSnapshot?.data()
          as Map<String, dynamic>?)?['inviterId'] as String?;

      opponentId = remoteOpponentId!;
      challengeId = event.challengeId!;
    }

    log('challengeId $challengeId');
    final opponentRef = FirebaseFirestore.instance.collection('players').doc(
          opponentId,
        );
    final opponentSnapshot = await opponentRef.get();
    final data = opponentSnapshot.data();
    final opponent = JakisLifePlayer(
      id: opponentId,
      highScore: 0,
      displayName: data?['displayName'] as String?,
      photoUrl: data?['photoUrl'] as String?,
    );
    final self = JakisLifePlayer(
      id: selfId,
      highScore: 0,
      displayName: currentUser.displayName,
      photoUrl: currentUser.photoURL,
    );
    emit(
      state.copyWith(
        challengeId: challengeId,
        players: [opponent, self],
      ),
    );

    log('players ${state.players}');

    _challengeRef?.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final players = <JakisLifePlayer>[];
        final data = snapshot.data() as Map<String, dynamic>?;
        log('data $data');
        final playersId = data?['players'] as List<dynamic>?;
        log('playersId $playersId');
        if (playersId != null) {
          for (final (id as String) in playersId) {
            final localPlayer =
                state.players?.where((player) => player.id == id).firstOrNull;
            final playersScore = data?['playersScore'] as Map<String, dynamic>?;
            final playersState = data?['playersState'] as Map<String, dynamic>?;
            if (localPlayer == null) return;

            players.add(
              localPlayer.copyWith(
                id: id,
                highScore: (playersScore?[id] as int?) ?? 0,
                playerState:
                    (playersState?[id] as String?) ?? PlayersState.standby,
              ),
            );
          }
        }
        log('players $players');
        add(UpdatePlayers(players: players));
      }
    });
  }

  Future<void> _onUpdatePlayers(
    UpdatePlayers event,
    Emitter<MultiplayerState> emit,
  ) async {
    emit(state.copyWith(players: event.players));
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
    add(UpdatePlayerData(playersState: event.playersState));
  }

  Future<void> _onUpdateScore(
    UpdateScore event,
    Emitter<MultiplayerState> emit,
  ) async {
    add(UpdatePlayerData(playersScore: event.score));
  }

  Future<void> _onUpdatePlayerData(
    UpdatePlayerData event,
    Emitter<MultiplayerState> emit,
  ) async {
    if (state.challengeId == null) {
      return;
    }
    final currentUser = FirebaseAuth.instance.currentUser!;
    final challengeRef = FirebaseFirestore.instance
        .collection('challenges')
        .doc(state.challengeId);
    // .doc('CZExHdv58WW8kAHyEpV7');

    final snapshot = await challengeRef.get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) return;

      final playersScore = data['playersScore'] as Map<String, dynamic>?;
      if (event.playersScore != null) {
        playersScore?.update(
          currentUser.uid,
          (value) => event.playersScore,
        );
      }

      final playersState = data['playersState'] as Map<String, dynamic>?;
      if (event.playersState != null) {
        playersState?.update(
          currentUser.uid,
          (value) => event.playersState,
        );
      }

      await challengeRef.set(
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

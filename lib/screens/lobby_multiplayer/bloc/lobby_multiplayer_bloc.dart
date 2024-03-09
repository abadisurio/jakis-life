import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'lobby_multiplayer_event.dart';
part 'lobby_multiplayer_state.dart';

class LobbyMultiplayerBloc
    extends Bloc<LobbyMultiplayerEvent, LobbyMultiplayerState> {
  LobbyMultiplayerBloc() : super(const LobbyMultiplayerState()) {
    on<StartMultiplayerSession>(_onStartMultiplayerSession);
  }

  Future<void> _onStartMultiplayerSession(
    StartMultiplayerSession event,
    Emitter<LobbyMultiplayerState> emit,
  ) async {
    // showNotification('title', 'body', 'routeName');

    log('wkwkwk');
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      // await flutterLocalNotificationsPlugin.show(
      //   3217362,
      //   'notification.title',
      //   'notification.body',
      //   NotificationDetails(
      //     android: AndroidNotificationDetails(
      //       channel.id,
      //       channel.name,
      //       channelDescription: channel.description,
      //       icon: 'mipmap/ic_launcher',
      //     ),
      //   ),
      //   payload: 'testtt',
      // );

      final response = await FirebaseFunctions.instance
          .httpsCallable('createMultiplayer')
          .call<Map<String, dynamic>>(
        {
          'inviterId': currentUser?.uid,
          'invitedId': event.invitedId,
        },
      );
      log('response ${response.data}');
    } catch (e) {
      log('eee $e');
    }
  }
}

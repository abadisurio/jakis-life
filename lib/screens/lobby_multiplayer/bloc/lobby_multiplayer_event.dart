part of 'lobby_multiplayer_bloc.dart';

class LobbyMultiplayerEvent {
  const LobbyMultiplayerEvent();
}

class StartMultiplayerSession extends LobbyMultiplayerEvent {
  const StartMultiplayerSession({
    required this.invitedId,
  });

  final String invitedId;
}

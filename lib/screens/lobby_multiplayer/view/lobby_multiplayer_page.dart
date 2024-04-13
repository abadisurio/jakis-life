import 'dart:math' show pi;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';

import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/shared/bloc/multiplayer_bloc/multiplayer_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

part 'card.dart';
part 'card_back.dart';
part 'card_front.dart';

@RoutePage()
class LobbyMultiplayerPage extends StatefulWidget {
  const LobbyMultiplayerPage({
    super.key,
    @PathParam('invitedId') this.invitedId,
    @PathParam('challengeId') this.challengeId,
  });

  final String? invitedId;
  final String? challengeId;

  @override
  State<LobbyMultiplayerPage> createState() => _LobbyMultiplayerPageState();
}

class _LobbyMultiplayerPageState extends State<LobbyMultiplayerPage> {
  @override
  void initState() {
    if (widget.invitedId != null) {
      context
          .read<MultiplayerBloc>()
          .add(StartMultiplayerSession(invitedId: widget.invitedId));
    } else if (widget.challengeId != null) {
      context
          .read<MultiplayerBloc>()
          .add(StartMultiplayerSession(challengeId: widget.challengeId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Play with your friends!'),
      ),
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  switchInCurve: Curves.easeOutCirc,
                  switchOutCurve: Curves.easeOutCirc,
                  child: () {
                    if (state.authState == AuthState.signedIn) {
                      if (widget.invitedId != null ||
                          widget.challengeId != null) {
                        return const _LobbyMultiplayerStandby();
                      } else if (state.isMultiplayerUnlocked) {
                        return const _LobbyMultiplayerView();
                      }
                    }
                    return const _LobbyMultiplayerLockedView();
                  }(),
                );
              },
            ),
            const PlayerCard(),
          ],
        ),
      ),
    );
  }
}

class _LobbyMultiplayerView extends StatelessWidget {
  const _LobbyMultiplayerView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 100),
        _Card(),
      ],
    );
  }
}

class _LobbyMultiplayerLockedView extends StatelessWidget {
  const _LobbyMultiplayerLockedView();

  @override
  Widget build(BuildContext context) {
    final highScore = context.read<PlayerBloc>().state.highScore;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height -
                (kToolbarHeight +
                    MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).padding.bottom),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<PlayerBloc, PlayerState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  Text(
                    'Play with your friends',
                    style: TextStyleTheme(context).titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Assets.images.jakiRound.image(),
                  const SizedBox(height: 32),
                  Text(
                    'Get your score pass ${PlayerState.minimumHighScore} and get badge to play with your friend',
                    style: TextStyleTheme(context).bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Your current high score is',
                    style: TextStyleTheme(context).titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$highScore',
                    style: TextStyleTheme(context).titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  KJButton(
                    onPressed: () {
                      context.router.replace(const GameRandomizerRoute());
                    },
                    child: Text(
                      'Start Grinding!',
                      style: TextStyleTheme(context).titleSmall?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LobbyMultiplayerStandby extends StatelessWidget {
  const _LobbyMultiplayerStandby();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MultiplayerBloc, MultiplayerState>(
      listener: (context, state) {
        final readyToStart = state.players
                ?.where((player) => player.playerState == PlayersState.standby)
                .length ==
            state.players?.length;

        if (readyToStart) {
          context.router.replace(const GameRandomizerRoute());
        }
      },
      listenWhen: (prev, curr) => curr.players?.isNotEmpty ?? false,
      buildWhen: (prev, curr) => curr.players?.isNotEmpty ?? false,
      builder: (context, state) {
        final text =
            'Get ready to play ${state.opponents?.first.displayName == null ? '' : 'with ${state.opponents?.first.displayName}'}';
        return ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height -
                  (kToolbarHeight +
                      MediaQuery.of(context).padding.top +
                      MediaQuery.of(context).padding.bottom),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 96,
                  foregroundImage: CachedNetworkImageProvider(
                    state.opponents?.first.photoUrl ??
                        'https://picsum.photos/200',
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  text,
                  style: TextStyleTheme(context).titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (state.self?.playerState == PlayersState.standby)
                  const CircularProgressIndicator(),
                if (state.self?.playerState == PlayersState.waiting)
                  KJButton(
                    onPressed: () {
                      context.read<MultiplayerBloc>().add(const StandbyGame());
                    },
                    child: Text(
                      'Start Game',
                      style: TextStyleTheme(context).titleSmall?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

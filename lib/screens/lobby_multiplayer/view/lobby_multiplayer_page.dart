import 'dart:math' show pi;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';
import 'package:jakislife/bloc/player_bloc.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

part 'card.dart';
part 'card_back.dart';
part 'card_front.dart';

@RoutePage()
class LobbyMultiplayerPage extends StatefulWidget {
  const LobbyMultiplayerPage({super.key});

  @override
  State<LobbyMultiplayerPage> createState() => _LobbyMultiplayerPageState();
}

class _LobbyMultiplayerPageState extends State<LobbyMultiplayerPage> {
  // late bool _isUnlocked;
  @override
  void initState() {
    // final state = context.read<PlayerBloc>().state;
    // _isUnlocked = state.isMultiplayerUnlocked;
    // log('state ${state.currentUser}');
    // log('_isUnlocked $_isUnlocked');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (_isUnlocked) {}
    // return const _LobbyMultiplayerLockedView();
    return const _LobbyMultiplayerView();
  }
}

class _LobbyMultiplayerView extends StatelessWidget {
  const _LobbyMultiplayerView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Play with your friends!'),
      ),
      backgroundColor: Colors.blue.shade100,
      body: ListView(
        children: [
          const SizedBox(height: 32),
          const _Card(),
          Center(
            child: KJButton(
              onPressed: () {
                context.read<PlayerBloc>().add(const PlayerSignIn());
              },
              child: Text(
                'Start Grinding!',
                style: TextStyleTheme(context).titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
          Center(
            child: KJButton(
              onPressed: () {
                context.read<PlayerBloc>().add(const PlayerSignOut());
              },
              child: Text(
                'Sign Out',
                style: TextStyleTheme(context).titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LobbyMultiplayerLockedView extends StatelessWidget {
  const _LobbyMultiplayerLockedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blue.shade100,
      body: ListView(
        children: [
          Center(
            child: Text(
              'Play with your friends',
              style: TextStyleTheme(context).titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Assets.images.jakiRound.image(),
          ),
          Center(
            child: Text(
              'Get your score pass 1000 and get badge to play with your friend',
              style: TextStyleTheme(context).bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: KJButton(
              onPressed: () {
                context.router.push(const GameRandomizerRoute());
              },
              child: Text(
                'Start Grinding!',
                style: TextStyleTheme(context).titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

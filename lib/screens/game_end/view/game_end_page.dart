import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/shared/bloc/multiplayer_bloc/multiplayer_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

@RoutePage()
class GameEndPage extends StatelessWidget {
  const GameEndPage({super.key, this.showBadge = false});

  final bool? showBadge;

  @override
  Widget build(BuildContext context) {
    return (showBadge ?? false)
        ? const _GameEndBadgeUnlocked()
        : const _GameEndView();
  }
}

class _GameEndView extends StatelessWidget {
  const _GameEndView();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Game Ended',
            style: TextStyleTheme(context).titleMedium,
          ),
          const SizedBox(height: 40),
          KJButton(
            onPressed: () {
              context.router
                  .popUntil((route) => route.data?.name == LobbyRoute.name);
              context.read<MultiplayerBloc>().add(const ResetMultiplayer());
            },
            child: Text(
              'Back to Lobby',
              style: TextStyleTheme(context).titleSmall,
            ),
          ),
          const MultiplayerScores(),
        ],
      ),
    );
  }
}

class _GameEndBadgeUnlocked extends StatefulWidget {
  const _GameEndBadgeUnlocked();

  @override
  State<_GameEndBadgeUnlocked> createState() => _GameEndBadgeUnlockedState();
}

class _GameEndBadgeUnlockedState extends State<_GameEndBadgeUnlocked>
    with TickerProviderStateMixin {
  bool _isMounted = false;
  bool _isShowButton = false;
  Widget? badge;
  final badges = [
    Assets.svg.jakisBadge1,
    Assets.svg.jakisBadge2,
    Assets.svg.jakisBadge3,
  ];

  @override
  void initState() {
    context.read<PlayerBloc>().add(const EarnBadge());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final badgeSeries = context.read<PlayerBloc>().state.badgeSeries ?? 0;
      setState(() {
        _isMounted = true;
        badge = badges[badgeSeries].svg();
      });
      Future.delayed(const Duration(milliseconds: 4000), () {
        setState(() {
          _isShowButton = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('_isMounted $_isMounted');
    return Material(
      color: Colors.blue.shade200,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.bounceOut,
              scale: _isMounted ? 1 : 0,
              child: AnimatedRotation(
                turns: _isMounted ? 3 : 0,
                curve: Curves.easeOutCirc,
                duration: const Duration(seconds: 10),
                child: Icon(
                  Icons.stars,
                  size: 20,
                  color: Colors.yellow.shade300,
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 4000),
            curve: Curves.easeOutCirc,
            alignment: _isMounted ? Alignment.center : const Alignment(0, 10),
            child: SizedBox(
              height: 400,
              width: 300,
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: badge,
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeOutCirc,
            alignment: _isMounted
                ? Alignment.center.add(const Alignment(0, -0.2))
                : const Alignment(0, -10),
            child: Text(
              'You have earned a Badge!',
              style: TextStyleTheme(context).titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          AnimatedOpacity(
            opacity: _isShowButton ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Align(
              alignment: Alignment.center.add(const Alignment(0, 0.7)),
              child: KJButton(
                onPressed: () {
                  context.router.replace(LobbyMultiplayerRoute());
                },
                child: Text(
                  'See my badge',
                  style: TextStyleTheme(context).titleSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

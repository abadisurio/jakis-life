import 'dart:developer';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/bloc/player_bloc.dart';
import 'package:jakislife/games/games.dart';

@RoutePage()
class GameRandomizerPage extends StatefulWidget {
  const GameRandomizerPage({
    super.key,
  });

  @override
  State<GameRandomizerPage> createState() => _GameRandomizerPageState();
}

class _GameRandomizerPageState extends State<GameRandomizerPage> {
  late Widget game;
  late PlayerBloc _playerBloc;
  String? _previousGameName;

  @override
  void initState() {
    _playerBloc = context.read<PlayerBloc>();
    _previousGameName = _playerBloc.state.currentGame;
    do {
      game = _randomizeGame();
    } while (game.runtimeType.toString() == _previousGameName);
    context
        .read<PlayerBloc>()
        .add(UpdateCurrentGame(gameName: game.runtimeType.toString()));
    log('game.runtimeType.toString() ${game.runtimeType}');
    super.initState();
  }

  Widget _randomizeGame() {
    return switch (math.Random().nextInt(6)) {
      0 => const TelorGulung(),
      1 => const StableSidewalk(),
      2 => const CommuterRush(),
      3 => const LitterPicker(),
      4 => const CollectSocket(),
      5 => const BatteryParry(),
      int() => const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    // return const TelorGulung();
    // return const StableSidewalk();
    // return const CommuterRush();
    // return const LitterPicker();
    // return const CollectSocket();
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => false,
      // child: const BatteryParry(),
      // child: const TelorGulung(),
      // child: const StableSidewalk(,
      // child: const CommuterRush(),
      // child: const LitterPicker(),
      // child: const CollectSocket(),
      // child: const CutScenePage(isWin: true),
      child: game,
    );
    // return game;
  }
}

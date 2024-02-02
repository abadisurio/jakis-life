import 'dart:developer';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/bloc/player_bloc.dart';
import 'package:katajakarta/games/games.dart';

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
    log('_previousGameName $_previousGameName');
    do {
      game = _randomizeGame();
    } while (game.runtimeType.toString() == _playerBloc.state.currentGame);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // log('previousGameName: ${game.runtimeType}');
    // });
    context
        .read<PlayerBloc>()
        .add(UpdateCurrentGame(gameName: game.runtimeType.toString()));
    super.initState();
  }

  Widget _randomizeGame() {
    return switch (math.Random().nextInt(4)) {
      0 => const TelorGulung(),
      1 => const StableSidewalk(),
      2 => const CommuterRush(),
      3 => const LitterPicker(),
      int() => const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return const LitterPicker();
  }
}

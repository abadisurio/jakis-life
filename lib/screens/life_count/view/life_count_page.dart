import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/router/jakislife_route.dart';
import 'package:jakislife/utils/text_theme.dart';

@RoutePage()
class LifeCountPage extends StatelessWidget {
  const LifeCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LifeCountView();
  }
}

class _LifeCountView extends StatefulWidget {
  const _LifeCountView();

  @override
  State<_LifeCountView> createState() => _LifeCountViewState();
}

class _LifeCountViewState extends State<_LifeCountView> {
  late int _lifeCount;
  @override
  void initState() {
    log('LifeCountPage mounted');
    final state = context.read<PlayerBloc>().state;
    _lifeCount = state.life;

    if (state.isCurrentGameWin) {
      context.read<PlayerBloc>().add(const IncreasePoint());
    } else {
      context.read<PlayerBloc>().add(const DecreaseLife());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (_lifeCount <= 0) {
          context.read<PlayerBloc>().add(const ResetLife());
          context.router.replace(
            GameEndRoute(
              showBadge: state.highScore < PlayerState.minimumHighScore &&
                  state.latestScore >= PlayerState.minimumHighScore,
            ),
          );
        } else {
          context.router.replace(const GameRandomizerRoute());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Life $_lifeCount'),
          const _PointCount(),
        ],
      ),
    );
  }
}

class _PointCount extends StatefulWidget {
  const _PointCount();

  @override
  State<_PointCount> createState() => _PointCountState();
}

class _PointCountState extends State<_PointCount>
    with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late int _prevPoint;
  late int _point;

  @override
  void initState() {
    final state = context.read<PlayerBloc>().state;
    _point = state.latestScore;
    _prevPoint = _point;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('_point $_point');
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) {
        setState(() {
          _point = state.latestScore;
        });
        _animationController.forward();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final point =
              _prevPoint + (_point - _prevPoint) * _animationController.value;
          return Text(
            '${point.toInt()}',
            style: TextStyleTheme(context).bodyMedium,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

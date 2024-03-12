import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/shared/bloc/multiplayer_bloc/multiplayer_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/router/jakislife_route.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/multiplayer_scores.dart';

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
    final state = context.read<PlayerBloc>().state;
    _lifeCount = state.life;

    if (state.isCurrentGameWin) {
      context.read<PlayerBloc>().add(const IncreasePoint());
      final state = context.read<PlayerBloc>().state;
      context
          .read<MultiplayerBloc>()
          .add(UpdateScore(score: state.latestScore));
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
      color: Colors.green.shade200,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LifeCount(),
          _PointCount(),
          MultiplayerScores(),
        ],
      ),
    );
  }
}

class _LifeCount extends StatefulWidget {
  const _LifeCount();
  @override
  State<_LifeCount> createState() => _LifeCountState();
}

class _LifeCountState extends State<_LifeCount> {
  int _lifeCount = 3;
  int _lifeDifference = 0;
  @override
  void initState() {
    final state = context.read<PlayerBloc>().state;
    _lifeCount = state.life;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _lifeDifference = state.isCurrentGameWin ? 0 : -1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('Life ${_lifeCount} ${_lifeDifference}');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 500),
          crossFadeState: index + 1 <= _lifeCount + _lifeDifference
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Icon(
            Icons.favorite,
            size: 80,
            color: Colors.red.shade500,
          ),
          secondChild: Icon(
            Icons.favorite_outline_rounded,
            size: 80,
            color: Colors.red.shade500,
          ),
        );
      }),
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
            style: TextStyleTheme(context).titleLarge,
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

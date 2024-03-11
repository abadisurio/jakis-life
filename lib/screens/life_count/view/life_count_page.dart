import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/model/jakislife_player.dart';
import 'package:jakislife/shared/bloc/multiplayer_bloc/multiplayer_bloc.dart';
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
      final latestScore = context.read<PlayerBloc>().state.latestScore;
      context.read<MultiplayerBloc>().add(UpdateScore(score: latestScore));
    } else {
      context.read<PlayerBloc>().add(const DecreaseLife());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (_lifeCount <= 1) {
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
          _MultiplayerScores(),
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
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _lifeDifference = state.isCurrentGameWin ? 0 : -1;
        });
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

class _MultiplayerScores extends StatefulWidget {
  const _MultiplayerScores();

  @override
  State<_MultiplayerScores> createState() => _MultiplayerScoresState();
}

class _MultiplayerScoresState extends State<_MultiplayerScores> {
  List<JakisLifePlayer>? _mpPlayers;
  JakisLifePlayer? _mpSelf;
  MultiplayerState? _mpState;
  @override
  void initState() {
    _mpState = context.read<MultiplayerBloc>().state;
    if (_mpState?.challengeId != null) {
      setState(() {
        _mpPlayers = [..._mpState?.players ?? []];
        _mpSelf = _mpState?.self;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _mpPlayers?.sort(
      (prev, curr) => (curr.highScore ?? 0).compareTo(prev.highScore ?? 0),
    );
    if (_mpPlayers == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // color: Colors.red,
      height: 400,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _mpPlayers?.length ?? 0,
        itemBuilder: (context, index) {
          final player = _mpPlayers![index];
          // final player = JakisLifePlayer(
          //   id: 'id',
          //   displayName: 'nama',
          //   highScore: 3043,
          //   photoUrl: 'https://www.gstatic.com/webp/gallery/1.jpg',
          // );
          return Row(
            children: [
              CircleAvatar(
                child: Text('${index + 1}'),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 8, right: 32),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        player.photoUrl ??
                            'https://www.gstatic.com/webp/gallery/1.jpg',
                      ),
                    ),
                    title: Text(
                      player.displayName ?? 'Player ${index + 1}',
                      style: player.id != _mpSelf?.id
                          ? null
                          : TextStyleTheme(context).titleSmall,
                    ),
                    trailing: Text(
                      '${player.highScore}',
                      style: TextStyleTheme(context).bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

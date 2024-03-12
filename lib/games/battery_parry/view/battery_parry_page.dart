import 'dart:async';

import 'dart:math' hide log;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/games/battery_parry/battery_parry.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/screens/pause/bloc/pause_bloc.dart';

import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

part 'battery.dart';

class BatteryParry extends StatelessWidget {
  const BatteryParry({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BatteryParryBloc(),
      child: const _BatteryParryView(),
    );
  }
}

class _BatteryParryView extends StatefulWidget {
  const _BatteryParryView();

  @override
  State<_BatteryParryView> createState() => _BatteryParryViewState();
}

class _BatteryParryViewState extends State<_BatteryParryView> {
  final _batteries = <_Battery>[];
  int _flickCount = 0;
  late final _level = context.read<PlayerBloc>().state.latestScore ~/ 200;
  late int _batteriesCount;
  late Stream<int> _stream;
  late StreamSubscription<void> _streamSubscription;

  @override
  void initState() {
    _batteriesCount = 3 + _level;
    _stream = Stream.periodic(const Duration(milliseconds: 1000), (i) => i)
        .take(_batteriesCount);
    _streamSubscription = _stream.listen(_addBattery);
    super.initState();
  }

  int _addBattery(int index) {
    _batteries.add(
      _Battery(
        offset: Offset((Random().nextInt(4) - 2) * 10, 0),
        onFlick: _flickBattery,
      ),
    );
    setState(() {});
    return index;
  }

  void _flickBattery() {
    _flickCount += 1;
    if (_flickCount == _batteriesCount) {
      context.read<BatteryParryBloc>().add(const EndGame(isWin: true));
    }
  }

  @override
  void dispose() {
    _batteries.clear();
    _streamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PauseBloc, PauseState>(
          listener: (context, state) {
            if (state.isPaused) {
              _streamSubscription.pause();
            } else {
              _streamSubscription.resume();
            }
          },
          listenWhen: (prev, curr) => prev.isPaused != curr.isPaused,
        ),
        BlocListener<BatteryParryBloc, BatteryParryState>(
          listener: (context, state) {
            Future.delayed(const Duration(milliseconds: 500), () {
              // context.router.replace(
              //   CutSceneRoute(isWin: state.isWin ?? false),
              // );
              context
                  .read<PlayerBloc>()
                  .add(UpdateCurrentGameWin(isWin: state.isWin ?? false));
              context.router.replace(const LifeCountRoute());
            });
          },
          listenWhen: (prev, curr) => curr.isWin != null,
        ),
      ],
      child: Material(
        color: Colors.blue.shade100,
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(top: 50, right: 25, child: PauseButton()),
              Positioned.fill(
                bottom: 400,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Flick',
                        style: TextStyleTheme(context).titleLarge,
                      ),
                      Text(
                        '''the batteries from the ground''',
                        style: TextStyleTheme(context).bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.green.shade200,
                  height: 120,
                  width: double.infinity,
                ),
              ),
              ..._batteries,
            ],
          ),
        ),
      ),
    );
  }
}

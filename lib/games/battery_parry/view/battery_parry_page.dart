import 'dart:async';
import 'dart:math' hide log;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/gen/assets.gen.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';

import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

part 'battery.dart';

class BatteryParry extends StatelessWidget {
  const BatteryParry({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BatteryParryView();
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
  static const _batteriesCount = 5;
  late Stream<int> _stream;
  late StreamSubscription<void> _streamSubscription;

  @override
  void initState() {
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
      Future.delayed(const Duration(milliseconds: 500), () {
        context.router.replace(
          CutSceneRoute(isWin: true),
        );
      });
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
    return BlocListener<PauseBloc, PauseState>(
      listener: (context, state) {
        if (state.isPaused) {
          _streamSubscription.pause();
        } else {
          _streamSubscription.resume();
        }
      },
      listenWhen: (prev, curr) => prev.isPaused != curr.isPaused,
      child: Material(
        color: Colors.green.shade100,
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
                        '''the batteries from the river''',
                        style: TextStyleTheme(context).bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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

import 'dart:async';
import 'dart:math' hide log;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';

import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

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
    _stream = Stream.periodic(const Duration(seconds: 1), (i) => i)
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

class _Battery extends StatefulWidget {
  const _Battery({
    required this.onFlick,
    this.offset = Offset.zero,
  });

  final Offset offset;
  final VoidCallback onFlick;

  @override
  State<_Battery> createState() => __BatteryState();
}

class __BatteryState extends State<_Battery> with TickerProviderStateMixin {
  static const _totalDuration = 5000;
  Offset? _flick;
  late final AnimationController _distanceController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: _totalDuration),
  );
  late final AnimationController _gravityController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: _totalDuration),
  );
  late final CurvedAnimation _distance = CurvedAnimation(
    parent: _distanceController,
    curve: Curves.easeOutCubic,
  );
  late final CurvedAnimation _gravity = CurvedAnimation(
    parent: _gravityController,
    curve: Curves.easeIn,
  );
  static const double _iconSize = 48;
  static const double _y = 100;
  double? _initialX;
  double? _initialY;
  double _x = 0;
  double _screenWidth = 0;

  @override
  void initState() {
    _distanceController.forward();
    _gravityController.forward();
    _initialY = Random().nextInt(50) * 10 + 200.0;
    _gravityController.addListener(() {
      if ((_gravityController.value) >= 1) {
        _failGame();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenWidth = MediaQuery.of(context).size.width;
        _x = _screenWidth / 2;
        _initialX = (Random().nextBool() ? 0.7 : -0.7) * _screenWidth;
        _initialY =
            MediaQuery.of(context).size.height / (Random().nextInt(3) + 2);
      });
    });
    super.initState();
  }

  void _failGame() {
    _gravityController.stop();
    context.router.replace(
      CutSceneRoute(isWin: false),
    );
  }

  void _flickBattery(DragUpdateDetails detail) {
    if (_flick == null && detail.delta.dy <= -2) {
      _gravityController.stop();
      setState(() {
        _flick = detail.delta;
      });
      widget.onFlick.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialX == null || _initialY == null) {
      return const SizedBox.shrink();
    }
    return BlocListener<PauseBloc, PauseState>(
      listener: (context, state) {
        if (state.isPaused) {
          _distanceController.stop();
          _gravityController.stop();
        } else {
          _distanceController.forward();
          _gravityController.forward();
        }
      },
      listenWhen: (prev, curr) => prev.isPaused != curr.isPaused,
      child: AnimatedBuilder(
        animation: Listenable.merge([_distance, _gravity]),
        builder: (context, child) {
          return AnimatedPositioned(
            duration:
                _flick == null ? Duration.zero : const Duration(seconds: 1),
            bottom: widget.offset.dy +
                _y +
                _initialY! * (1 - _gravity.value) +
                _gravity.value +
                (_flick == null
                    ? 0
                    : _flick!.dy.clamp(-2, 0) * -_screenWidth * 2),
            left: widget.offset.dx +
                _x +
                _initialX! * (1 - _distance.value) +
                _distance.value +
                (_flick == null
                    ? 0
                    : _flick!.dx.clamp(-2, 2) * _screenWidth * 2),
            child: child!,
          );
        },
        child: GestureDetector(
          onPanUpdate: _flickBattery,
          child: const SizedBox(
            height: 80,
            width: 80,
            child: Icon(
              Icons.battery_2_bar,
              size: _iconSize,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _gravityController.dispose();
    super.dispose();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/games/stable_sidewalk/bloc/stable_sidewalk_bloc.dart';

class StableSidewalkPage extends StatelessWidget {
  const StableSidewalkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StableSidewalkBloc();
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: SizedBox.fromSize(
          size: MediaQuery.of(context).size,
          child: SafeArea(
            child: Column(
              children: [
                const _Progress(),
                Expanded(
                  child: Stack(
                    children: [
                      const Text('text'),
                      Center(
                        child: Transform(
                          // Transform widget
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.05) // perspective
                            ..rotateX(-0.2), // changed
                          child: const _Sidewalk(),
                        ),
                      ),
                      const Positioned.fill(
                        top: 100,
                        child: Center(child: _Character()),
                      ),
                      const Center(child: _GameStatus()),
                      const Positioned(
                        bottom: 100,
                        left: 60,
                        child: _LeftButton(),
                      ),
                      const Positioned(
                        bottom: 100,
                        right: 60,
                        child: _RightButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GameStatus extends StatelessWidget {
  const _GameStatus();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StableSidewalkBloc, StableSidewalkState>(
      builder: (context, state) {
        if (state.isWin != null) {
          return Text(state.isWin! ? 'You Win!' : 'You Lose!');
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _Progress extends StatefulWidget {
  const _Progress();

  @override
  State<_Progress> createState() => _ProgressState();
}

class _ProgressState extends State<_Progress> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 15),
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
    _animationController
      ..forward()
      ..addListener(() {
        // log('progress');
        context.read<StableSidewalkBloc>().add(AddWeight());
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return BlocListener<StableSidewalkBloc, StableSidewalkState>(
          listener: (context, state) {
            if (state.isWin != null) {
              _animationController.stop();
            }
          },
          listenWhen: (prev, curr) => prev.isWin != curr.isWin,
          child: LinearProgressIndicator(value: _animationController.value),
        );
      },
    );
  }
}

class _LeftButton extends StatefulWidget {
  const _LeftButton();

  @override
  State<_LeftButton> createState() => _LeftButtonState();
}

class _LeftButtonState extends State<_LeftButton> {
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        context.read<StableSidewalkBloc>().add(WeightLeft());
      },
      onLongPressStart: (detail) {
        setState(() {
          timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
            context.read<StableSidewalkBloc>().add(WeightLeft());
          });
        });
      },
      onLongPressEnd: (detail) {
        timer?.cancel();
      },
      child: const Icon(Icons.arrow_left_rounded),
    );
  }
}

class _RightButton extends StatefulWidget {
  const _RightButton();

  @override
  State<_RightButton> createState() => _RightButtonState();
}

class _RightButtonState extends State<_RightButton> {
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        context.read<StableSidewalkBloc>().add(WeightRight());
      },
      onLongPressStart: (detail) {
        setState(() {
          timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
            context.read<StableSidewalkBloc>().add(WeightRight());
          });
        });
      },
      onLongPressEnd: (detail) {
        timer?.cancel();
      },
      child: const Icon(Icons.arrow_right_rounded),
    );
  }
}

class _Sidewalk extends StatefulWidget {
  const _Sidewalk();

  @override
  State<_Sidewalk> createState() => _SidewalkState();
}

class _SidewalkState extends State<_Sidewalk> with TickerProviderStateMixin {
  bool _dark = true;
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();

  @override
  void initState() {
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        setState(() {
          _dark = !_dark;
        });
        _animationController
          ..reset()
          ..forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const stripeCount = 50;
    const sidewalkHeight = 500.0;
    const stripeHeight = sidewalkHeight / (stripeCount * 2);
    return SizedBox(
      width: 40,
      height: sidewalkHeight,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Column(
                children: [
                  ...List.generate(stripeCount * 3, (index) {
                    if (index % 3 == 0) {
                      return Container(
                        color:
                            _dark ? Colors.grey.shade800 : Colors.grey.shade100,
                        height: stripeHeight * _animationController.value,
                      );
                    }
                    if (index % 3 == 2) {
                      return Container(
                        color:
                            _dark ? Colors.grey.shade800 : Colors.grey.shade100,
                        height: stripeHeight * (1 - _animationController.value),
                      );
                    }
                    return Container(
                      color:
                          _dark ? Colors.grey.shade100 : Colors.grey.shade800,
                      height: stripeHeight,
                    );
                  }),
                ],
              );
            },
          ),
          Positioned.fill(
            left: 10,
            right: 10,
            child: ColoredBox(color: Colors.grey.shade300),
          ),
        ],
      ),
    );
  }
}

class _Character extends StatefulWidget {
  const _Character();

  @override
  State<_Character> createState() => __CharacterState();
}

class __CharacterState extends State<_Character> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StableSidewalkBloc, StableSidewalkState>(
      builder: (context, state) {
        return AnimatedRotation(
          turns: 0.01 * state.weight * 3.14,
          duration: const Duration(milliseconds: 500),
          // angle: 0.1 * state.weight,
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.red,
            height: 200,
            width: 80,
          ),
        );
      },
    );
  }
}

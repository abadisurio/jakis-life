import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/games/stable_sidewalk/bloc/stable_sidewalk_bloc.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

@RoutePage()
class StableSidewalkPage extends StatelessWidget {
  const StableSidewalkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StableSidewalkView();
  }
}

class _StableSidewalkView extends StatelessWidget {
  const _StableSidewalkView();

  @override
  Widget build(BuildContext context) {
    final bloc = StableSidewalkBloc();
    return BlocProvider(
      create: (_) => bloc,
      child: BlocListener<StableSidewalkBloc, StableSidewalkState>(
        bloc: bloc,
        listener: (context, state) {
          context.router.replace(
            CutSceneRoute(
              isWin: false,
              previousPageName: context.router.current.name,
            ),
          );
        },
        listenWhen: (prev, curr) => curr.isWin == false,
        child: Material(
          color: Colors.blue.shade100,
          child: SizedBox.fromSize(
            size: MediaQuery.of(context).size,
            child: SafeArea(
              child: Stack(
                children: [
                  GameProgress(
                    onTimeOut: () {
                      context.router.replace(
                        CutSceneRoute(
                          isWin: true,
                          previousPageName: context.router.current.name,
                        ),
                      );
                    },
                    onProgress: () {
                      bloc.add(AddWeight());
                    },
                    duration: const Duration(seconds: 10),
                  ),
                  const Positioned(top: 50, right: 25, child: PauseButton()),
                  Positioned.fill(
                    bottom: 400,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tap-tap!',
                            style: TextStyleTheme(context).titleLarge,
                          ),
                          Text(
                            '''Tap kiri atau kanan untuk menyeimbangkan jalan''',
                            style: TextStyleTheme(context).bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  // const Center(child: _GameStatus()),
                  const Positioned(
                    bottom: 100,
                    left: 30,
                    child: _LeftButton(),
                  ),
                  const Positioned(
                    bottom: 100,
                    right: 30,
                    child: _RightButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
      child: const Icon(
        Icons.arrow_left_rounded,
        size: 96,
      ),
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
      child: const Icon(
        Icons.arrow_right_rounded,
        size: 96,
      ),
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const stripeCount = 50;
    const sidewalkHeight = 500.0;
    const stripeHeight = sidewalkHeight / (stripeCount * 2);
    return BlocListener<PauseBloc, PauseState>(
      listener: (context, state) {
        if (state.isPaused) {
          _animationController.stop();
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            _animationController.forward();
          });
        }
      },
      child: SizedBox(
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
                          color: _dark
                              ? Colors.grey.shade800
                              : Colors.grey.shade100,
                          height: stripeHeight * _animationController.value,
                        );
                      }
                      if (index % 3 == 2) {
                        return Container(
                          color: _dark
                              ? Colors.grey.shade800
                              : Colors.grey.shade100,
                          height:
                              stripeHeight * (1 - _animationController.value),
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
      builder: (context, sidewalkState) {
        return BlocBuilder<PauseBloc, PauseState>(
          builder: (context, pauseState) {
            return AnimatedRotation(
              turns: 0.01 * sidewalkState.weight * 3.14,
              duration: pauseState.isPaused
                  ? Duration.zero
                  : const Duration(milliseconds: 500),
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
      },
    );
  }
}

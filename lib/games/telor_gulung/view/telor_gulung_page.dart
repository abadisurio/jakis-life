import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/games/telor_gulung/telor_gulung.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

@RoutePage()
class TelorGulungPage extends StatelessWidget {
  const TelorGulungPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TelurGulungView();
  }
}

class _TelurGulungView extends StatefulWidget {
  const _TelurGulungView();

  @override
  State<_TelurGulungView> createState() => _TelurGulungViewState();
}

class _TelurGulungViewState extends State<_TelurGulungView> {
  double _prevAtan = 0;
  double _totalAngle = 0;
  static const double _radius = 120;

  @override
  Widget build(BuildContext context) {
    final bloc = TelorGulungBloc();
    if (_totalAngle * 5 >= _radius) {
      context.router.replace(
        CutSceneRoute(
          isWin: true,
          previousPageName: context.router.current.name,
        ),
      );
    }
    return BlocProvider(
      create: (context) => bloc,
      child: Material(
        color: Colors.green.shade100,
        child: SafeArea(
          child: Stack(
            children: [
              const _GameProgress(),
              const Positioned(top: 50, right: 25, child: PauseButton()),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Gulung Telornya',
                      style: TextStyleTheme(context).titleLarge,
                    ),
                    const SizedBox(height: _radius * 3.5),
                    Text(
                      '''Putar sumpit sampai\ntelur matang''',
                      style: TextStyleTheme(context).bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: _totalAngle % (2 * math.pi),
                  child: GestureDetector(
                    onPanDown: (detail) {
                      _prevAtan = -math.atan2(
                        _radius - detail.localPosition.dx,
                        _radius - detail.localPosition.dy,
                      );
                    },
                    onPanUpdate: (dragUpdateDetails) {
                      final atan = -math.atan2(
                        _radius - dragUpdateDetails.localPosition.dx,
                        _radius - dragUpdateDetails.localPosition.dy,
                      );
                      // still not accurate because we rely on
                      // conditional values to calculate
                      final difference =
                          (atan.isNegative ? 2 * math.pi + atan : atan) -
                              _prevAtan;

                      _totalAngle += difference.abs() > 1 ? 0 : difference;
                      setState(() {
                        _prevAtan = atan.isNegative ? 2 * math.pi + atan : atan;
                      });
                      bloc.add(WeightRight());
                    },
                    child: CircleAvatar(
                      radius: _radius,
                      backgroundColor: Colors.grey.shade400,
                      child: BlocBuilder<TelorGulungBloc, TelorGulungState>(
                        builder: (context, state) {
                          return CircleAvatar(
                            backgroundColor: Colors.orange.shade200.withAlpha(
                              (255 - state.weight * 5).toInt().clamp(100, 255),
                            ),
                            radius: _radius - 16,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withAlpha(200),
                              radius: (_totalAngle * 5).clamp(1, _radius),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameProgress extends StatefulWidget {
  const _GameProgress();

  @override
  State<_GameProgress> createState() => _GameProgressState();
}

class _GameProgressState extends State<_GameProgress>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 7),
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
    _animationController
      ..forward()
      ..addListener(() {
        context.read<TelorGulungBloc>().add(AddWeight());
        if (_animationController.isCompleted) {
          context.router.replace(
            CutSceneRoute(
              isWin: false,
              previousPageName: context.router.current.name,
            ),
          );
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return BlocListener<TelorGulungBloc, TelorGulungState>(
            listener: (context, state) {
              _animationController.stop();
              if (state.isWin == false) {
                // context.router.replace(const LostRoute());
              }
            },
            listenWhen: (prev, curr) => prev.isWin != curr.isWin,
            child: LinearProgressIndicator(
              value: 1 - _animationController.value,
              minHeight: 25,
              color: Colors.black26,
              backgroundColor: Colors.white24,
            ),
          );
        },
      ),
    );
  }
}

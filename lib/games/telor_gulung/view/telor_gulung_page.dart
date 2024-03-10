import 'dart:developer';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/games/telor_gulung/telor_gulung.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';
import 'package:rive/rive.dart';

class TelorGulung extends StatelessWidget {
  const TelorGulung({super.key});

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
  SMINumber? _numSize;
  late final _level = context.read<PlayerBloc>().state.point ~/ 100;
  static const double _radius = 120;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _numSize = controller.findInput<double>('numSize') as SMINumber?;
    _numSize?.change(0);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = TelorGulungBloc();

    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<TelorGulungBloc, TelorGulungState>(
        bloc: bloc,
        listener: (context, state) {
          log('isWin: ${state.isWin}');
          if (state.isWin ?? false) {
            context.router.replace(
              CutSceneRoute(isWin: true),
            );
          }
        },
        listenWhen: (prev, curr) =>
            curr.isWin != prev.isWin && (curr.isWin != null),
        child: Material(
          color: Colors.green.shade100,
          child: SafeArea(
            child: Stack(
              children: [
                GameProgress(
                  onTimeOut: () {
                    context.router.replace(
                      CutSceneRoute(isWin: false),
                    );
                  },
                  onProgress: () {
                    bloc.add(AddWeight());
                  },
                  duration: Duration(milliseconds: 10000 - _level * 20),
                ),
                Assets.rive.telorGulung.rive(
                  onInit: _onRiveInit,
                ),
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
                  child: GestureDetector(
                    onPanDown: (detail) {
                      _prevAtan = -math.atan2(
                        _radius - detail.localPosition.dx,
                        _radius - detail.localPosition.dy,
                      );
                    },
                    onPanUpdate: _totalAngle * 5 >= _radius
                        ? null
                        : (dragUpdateDetails) {
                            final atan = -math.atan2(
                              _radius - dragUpdateDetails.localPosition.dx,
                              _radius - dragUpdateDetails.localPosition.dy,
                            );
                            // still not accurate because we rely on
                            // conditional values to calculate
                            final difference =
                                (atan.isNegative ? 2 * math.pi + atan : atan) -
                                    _prevAtan;

                            _totalAngle +=
                                difference.abs() > 1 ? 0 : difference;
                            setState(() {
                              _prevAtan =
                                  atan.isNegative ? 2 * math.pi + atan : atan;
                            });
                            _numSize
                                ?.change((_totalAngle * 3.6).clamp(1, _radius));
                            bloc.add(
                              WeightRight(
                                isWin: _totalAngle * 5 >= _radius ? true : null,
                              ),
                            );
                          },
                    child: CircleAvatar(
                      radius: _radius * 1.8,
                      backgroundColor: Colors.yellow.shade100.withOpacity(0.3),
                    ),
                    // child: const _Telor(),
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

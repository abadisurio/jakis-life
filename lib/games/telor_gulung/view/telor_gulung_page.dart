import 'dart:developer';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/games/telor_gulung/telor_gulung.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

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
  static const double _radius = 120;

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
                  duration: const Duration(seconds: 7),
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
                  child: Transform.rotate(
                    angle: _totalAngle % (2 * math.pi),
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
                              final difference = (atan.isNegative
                                      ? 2 * math.pi + atan
                                      : atan) -
                                  _prevAtan;

                              _totalAngle +=
                                  difference.abs() > 1 ? 0 : difference;
                              setState(() {
                                _prevAtan =
                                    atan.isNegative ? 2 * math.pi + atan : atan;
                              });
                              bloc.add(
                                WeightRight(
                                  isWin:
                                      _totalAngle * 5 >= _radius ? true : null,
                                ),
                              );
                            },
                      child: CircleAvatar(
                        radius: _radius,
                        backgroundColor: Colors.grey.shade400,
                        child: BlocBuilder<TelorGulungBloc, TelorGulungState>(
                          builder: (context, state) {
                            return CircleAvatar(
                              backgroundColor: Colors.orange.shade200.withAlpha(
                                (255 - state.weight * 5)
                                    .toInt()
                                    .clamp(100, 255),
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
      ),
    );
  }
}

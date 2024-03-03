import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/bloc/player_bloc.dart';
import 'package:jakislife/games/commuter_rush/commuter_rush.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

part 'widgets/right_door.dart';
part 'widgets/left_door.dart';
part 'widgets/door_case.dart';

class CommuterRush extends StatelessWidget {
  const CommuterRush({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommuterRushBloc(),
      child: const _CommuterRushView(),
    );
  }
}

class _CommuterRushView extends StatelessWidget {
  const _CommuterRushView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommuterRushBloc, CommuterRushState>(
      listener: (context, state) {
        final isWin = state.leftOffset >= 70 && state.rightOffset >= 70;
        // if (state.isWin ?? false) {
        if (isWin) {
          context.router.replace(
            CutSceneRoute(isWin: true),
          );
        }
      },
      child: Material(
        color: Colors.blue.shade100,
        child: SafeArea(
          child: Stack(
            children: [
              GameProgress(
                onTimeOut: () {
                  context.router.replace(CutSceneRoute(isWin: false));
                },
                duration: const Duration(seconds: 10),
              ),
              Positioned.fill(
                bottom: 400,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Pinch the doors',
                        style: TextStyleTheme(context).titleLarge,
                      ),
                      Text(
                        '''to get the train departed''',
                        style: TextStyleTheme(context).bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(top: 25, right: 25, child: PauseButton()),
              const Center(child: _Car()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Car extends StatelessWidget {
  const _Car();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(height: 220, child: Center(child: Passenger())),
        const Positioned(top: 40, child: _CarDoor()),
        IgnorePointer(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey.shade100,
              BlendMode.srcOut,
            ),
            child: SizedBox(
              height: 220,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        backgroundBlendMode: BlendMode.dstOut,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      width: 150,
                      height: 180,
                    ),
                  ),
                  Center(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            if (index == 1) {
                              return const SizedBox(width: 180);
                            }
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 80,
                              height: 80,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CarDoor extends StatelessWidget {
  const _CarDoor();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 180,
      width: 600,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CarDoorLeft(),
          _CarDoorRight(),
        ],
      ),
    );
  }
}

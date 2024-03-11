import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/games/litter_picker/litter_picker.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

class LitterPicker extends StatelessWidget {
  const LitterPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final level = context.read<PlayerBloc>().state.latestScore ~/ 100;
    return BlocProvider(
      create: (_) => LitterPickerBloc(level: level),
      child: const _LitterPickerView(),
    );
  }
}

class _LitterPickerView extends StatefulWidget {
  const _LitterPickerView();

  @override
  State<_LitterPickerView> createState() => _LitterPickerViewState();
}

class _LitterPickerViewState extends State<_LitterPickerView> {
  @override
  Widget build(BuildContext context) {
    final level = context.read<PlayerBloc>().state.latestScore ~/ 100;
    return Material(
      color: Colors.green.shade100,
      child: SafeArea(
        child: BlocListener<LitterPickerBloc, LitterPickerState>(
          listener: (context, state) {
            if (state.litterPickedCount >=
                state.litterCount - state.organicCount) {
              context.router.replace(
                CutSceneRoute(isWin: true),
              );
            }
          },
          child: BlocBuilder<LitterPickerBloc, LitterPickerState>(
            buildWhen: (prev, curr) {
              return prev.litterCount != curr.litterCount ||
                  prev.organicCount != curr.organicCount;
            },
            builder: (context, state) {
              return Stack(
                children: [
                  ...List.generate(
                    state.litterCount,
                    (index) => _Litter(
                      litterIndex: index,
                      isOrganic: index < state.organicCount,
                    ),
                  ),
                  GameProgress(
                    onTimeOut: () {
                      context.router.replace(
                        CutSceneRoute(isWin: false),
                      );
                    },
                    duration: Duration(seconds: (10 - level).clamp(2, 10)),
                  ),
                  const Positioned(top: 50, right: 25, child: PauseButton()),
                  Positioned.fill(
                    bottom: 400,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tap on the anorganic ones',
                            style: TextStyleTheme(context).titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '''to clean it''',
                            style: TextStyleTheme(context).bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Litter extends StatefulWidget {
  const _Litter({
    required this.litterIndex,
    required this.isOrganic,
  });

  final bool isOrganic;

  final int litterIndex;

  @override
  State<_Litter> createState() => _LitterState();
}

class _LitterState extends State<_Litter> {
  late Widget _litter;

  @override
  void initState() {
    if (widget.isOrganic) {
      _litter = littersOrganic.elementAt(math.Random().nextInt(3)).svg();
    } else {
      _litter = littersAnorganic
          .elementAt(math.Random().nextInt(littersAnorganic.length))
          .svg();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final randomHeight =
        math.Random().nextInt(size.height.toInt()) - size.height / 2.5;
    final randomWidth =
        math.Random().nextInt(size.width.toInt()) - size.width / 2.5;
    return Positioned.fill(
      top: randomHeight + 200,
      left: randomWidth,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (!widget.isOrganic) {
              context
                  .read<LitterPickerBloc>()
                  .add(PickLitter(litterIndex: widget.litterIndex));
            } else {
              context.router.replace(
                CutSceneRoute(isWin: false),
              );
            }
          },
          child: BlocBuilder<LitterPickerBloc, LitterPickerState>(
            buildWhen: (prev, curr) {
              return prev.litterPicked != curr.litterPicked &&
                  curr.litterPicked == widget.litterIndex;
            },
            builder: (context, state) {
              return state.litterPicked == widget.litterIndex
                  ? const SizedBox.shrink()
                  : SizedBox.square(
                      dimension: 100,
                      child: _litter,
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _LitterKind extends StatefulWidget {
  const _LitterKind();

  @override
  State<_LitterKind> createState() => _LitterKindState();
}

class _LitterKindState extends State<_LitterKind> {
  final litters = [
    {Assets.svg.anorganicBottleGlass: false},
    {Assets.svg.anorganicPlasticBag: false},
    {Assets.svg.anorganicTunaCan: false},
    {Assets.svg.anorganicSodaCan: false},
    {Assets.svg.organicApple: true},
    {Assets.svg.organicBone: true},
    {Assets.svg.organicEggShell: true},
    {Assets.svg.organicFishBone: true},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final littersAnorganic = [
  Assets.svg.anorganicBottleGlass,
  Assets.svg.anorganicPlasticBag,
  Assets.svg.anorganicTunaCan,
  Assets.svg.anorganicSodaCan,
];

final littersOrganic = [
  Assets.svg.organicApple,
  Assets.svg.organicBone,
  Assets.svg.organicEggShell,
  Assets.svg.organicFishBone,
];

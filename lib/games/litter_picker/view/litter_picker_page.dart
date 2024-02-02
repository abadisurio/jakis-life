import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/games/litter_picker/litter_picker.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

class LitterPicker extends StatelessWidget {
  const LitterPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LitterPickerBloc(),
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
    return Material(
      color: Colors.green.shade100,
      child: SafeArea(
        child: BlocSelector<LitterPickerBloc, LitterPickerState, int>(
          selector: (state) => state.litterCount,
          builder: (context, litterCount) {
            return Stack(
              children: [
                ...List.generate(
                  litterCount,
                  (index) => _Litter(litterIndex: index),
                ),
                GameProgress(
                  onTimeOut: () {
                    context.router.replace(
                      CutSceneRoute(isWin: false),
                    );
                  },
                  duration: const Duration(seconds: 7),
                ),
                const Positioned(top: 50, right: 25, child: PauseButton()),
                Positioned.fill(
                  bottom: 400,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tap on the litter',
                          style: TextStyleTheme(context).titleLarge,
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
    );
  }
}

class _Litter extends StatelessWidget {
  const _Litter({required this.litterIndex});

  final int litterIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final randomHeight =
        math.Random().nextInt(size.height.toInt()) - size.height / 2;
    final randomWidth =
        math.Random().nextInt(size.width.toInt()) - size.width / 2;
    return Positioned.fill(
      top: randomHeight + 200,
      left: randomWidth,
      child: Center(
        child: GestureDetector(
          onTap: () {
            context
                .read<LitterPickerBloc>()
                .add(PickLitter(litterIndex: litterIndex));
          },
          child: BlocBuilder<LitterPickerBloc, LitterPickerState>(
            buildWhen: (prev, curr) {
              if (curr.litterPickedCount >= curr.litterCount) {
                context.router.replace(
                  CutSceneRoute(isWin: true),
                );
              }
              return prev.litterPicked != curr.litterPicked &&
                  curr.litterPicked == litterIndex;
            },
            builder: (context, state) {
              return state.litterPicked == litterIndex
                  ? const SizedBox.shrink()
                  : Icon(
                      Icons.delete,
                      size: 100,
                      color: Colors.green.shade800,
                    );
            },
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

class CollectSocket extends StatelessWidget {
  const CollectSocket({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CollectSocketView();
  }
}

class _CollectSocketView extends StatefulWidget {
  const _CollectSocketView();

  @override
  State<_CollectSocketView> createState() => __CollectSocketViewState();
}

class __CollectSocketViewState extends State<_CollectSocketView> {
  final _removedPlugs = <int>[];
  final _hiddenSockets = <int>[];
  static const _pluggedSocketCount = 2;
  static const _totalSocketCount = 3;

  @override
  void initState() {
    for (var i = 0; i < _pluggedSocketCount; i++) {
      final hiddenSocket = Random().nextInt(_totalSocketCount);
      if (!_hiddenSockets.contains(hiddenSocket)) {
        _hiddenSockets.add(hiddenSocket);
      }
      if (_hiddenSockets.length == (_totalSocketCount - _pluggedSocketCount)) {
        break;
      }
    }
    super.initState();
  }

  void _removePlug(int index) {
    setState(() {
      _removedPlugs.add(index);
    });
    if (_removedPlugs.length == _pluggedSocketCount) {
      context.router.replace(
        CutSceneRoute(isWin: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.shade100,
      child: SafeArea(
        child: Stack(
          children: [
            GameProgress(
              onTimeOut: () {
                // context.router.replace(
                //   CutSceneRoute(isWin: false),
                // );
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
                      'Remove',
                      style: TextStyleTheme(context).titleLarge,
                    ),
                    Text(
                      '''the plug from the wall''',
                      style: TextStyleTheme(context).bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return const SizedBox.expand();
              },
              onAccept: _removePlug,
            ),
            // ...List.generate(4, (index) {
            //   return Positioned.fill(
            //     top: index * 200 - 200,
            //     child: Center(
            //       child: Draggable<int>(
            //         // Data is the value this Draggable stores.
            //         data: index,
            //         childWhenDragging: const _EmptySocket(),
            //         feedback: const _CableHead(),
            //         child: _acceptedData.contains(index)
            //             ? const _EmptySocket()
            //             : const _CableHead(),
            //       ),
            //     ),
            //   );
            // }),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_totalSocketCount, (index) {
                    return _removedPlugs.contains(index) ||
                            _hiddenSockets.contains(index)
                        ? const _EmptySocket()
                        : Draggable<int>(
                            // Data is the value this Draggable stores.
                            data: index,
                            childWhenDragging: const _EmptySocket(),
                            feedback: const _CableHead(),
                            child: const _CableHead(),
                          );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySocket extends StatelessWidget {
  const _EmptySocket();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
      child: const Icon(Icons.charging_station),
    );
  }
}

class _CableHead extends StatelessWidget {
  const _CableHead();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      height: 100,
      width: 100,
      child: const Icon(Icons.cable),
    );
  }
}

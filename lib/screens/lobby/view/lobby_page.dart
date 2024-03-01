import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

@RoutePage()
class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LobbyView();
  }
}

class _LobbyView extends StatelessWidget {
  const _LobbyView();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.shade100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Assets.rive.monasTest.rive(),
          Assets.svg.jakiTitle.svg(width: 300),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KJButton(
                    onPressed: () {
                      context.router.push(const GameRandomizerRoute());
                    },
                    child: Text(
                      'Lets go!',
                      style: TextStyleTheme(context)
                          .titleLarge
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                  const BacksoundPauseButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

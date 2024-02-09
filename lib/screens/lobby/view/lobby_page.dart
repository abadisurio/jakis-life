import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';
import 'package:rive/rive.dart';

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
          const RiveAnimation.asset('assets/rive/monas_test.riv'),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
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
                KJButton(
                  onPressed: () {},
                  child: const Icon(Icons.settings, size: 36),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

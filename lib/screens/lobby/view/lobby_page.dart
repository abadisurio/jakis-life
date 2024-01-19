import 'package:flutter/material.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KJButton(
              onPressed: () {},
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
        ));
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

@RoutePage()
class GameEndPage extends StatelessWidget {
  const GameEndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You Lost',
            style: TextStyleTheme(context).titleMedium,
          ),
          const SizedBox(height: 40),
          KJButton(
            onPressed: () {
              context.router
                  .popUntil((route) => route.data?.name == LobbyRoute.name);
            },
            child: Text(
              'Back to Lobby',
              style: TextStyleTheme(context).titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}

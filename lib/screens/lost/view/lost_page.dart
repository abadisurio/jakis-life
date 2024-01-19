import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

@RoutePage()
class LostPage extends StatelessWidget {
  const LostPage({super.key});

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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:katajakarta/router/router.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade300,
              offset: const Offset(0, 10),
              blurStyle: BlurStyle.solid,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(4),
            minimumSize: Size.zero,
            backgroundColor: Colors.orange.shade200,
          ),
          onPressed: () {
            context.router.push<bool?>(const PauseRoute());
            // final isResumed =
            //     await context.router.push<bool?>(const PauseRoute());
            // if (context.mounted && (isResumed ?? false)) {
            // }
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.pause),
          ),
        ),
      ),
    );
  }
}

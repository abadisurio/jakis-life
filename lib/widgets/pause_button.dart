import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/router/router.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';

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
          onPressed: () async {
            final isResumed =
                await context.router.push<bool?>(const PauseRoute());
            if (context.mounted && (isResumed ?? false)) {
              context.read<PauseBloc>().add(const PauseGame(isPaused: false));
            }
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

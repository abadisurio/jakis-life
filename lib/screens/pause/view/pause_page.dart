import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';
import 'package:katajakarta/utils/text_theme.dart';
import 'package:katajakarta/widgets/widgets.dart';

@RoutePage<bool?>()
class PausePage extends StatefulWidget {
  const PausePage({super.key});

  @override
  State<PausePage> createState() => _PausePageState();
}

class _PausePageState extends State<PausePage> {
  @override
  void initState() {
    super.initState();
    context.read<PauseBloc>().add(const PauseGame());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PauseBloc, PauseState>(
      listenWhen: (prev, curr) => !curr.isPaused,
      listener: (context, state) => context.router.pop(true),
      buildWhen: (prev, curr) => prev.isPaused != curr.isPaused,
      builder: (context, state) {
        return !state.isPaused
            ? const SizedBox.shrink()
            : Material(
                color: Colors.black26,
                child: Center(
                  child: AlertDialog(
                    title: Text(
                      'Game Paused',
                      style: TextStyleTheme(context).titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KJButton(
                          onPressed: () {
                            context
                                .read<PauseBloc>()
                                .add(const PauseGame(isPaused: false));
                          },
                          child: Text(
                            'Continue',
                            style: TextStyleTheme(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

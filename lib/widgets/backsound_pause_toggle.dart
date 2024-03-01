import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/app/app.dart';
import 'package:jakislife/widgets/widgets.dart';

class BacksoundPauseButton extends StatelessWidget {
  const BacksoundPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        // ToggleBacksoundPlayPause
        return KJButton(
          onPressed: () {
            context.read<AppBloc>().add(const ToggleBacksoundPlayPause());
          },
          child: Icon(
            state.isBacksoundPaused
                ? Icons.music_off_rounded
                : Icons.music_note_rounded,
            // size: 36,
          ),
        );
      },
    );
  }
}

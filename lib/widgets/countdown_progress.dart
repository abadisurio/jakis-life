import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/screens/pause/bloc/pause_bloc.dart';

class GameProgress extends StatefulWidget {
  const GameProgress({
    required this.onTimeOut,
    required this.duration,
    this.onProgress,
    super.key,
  });

  final VoidCallback onTimeOut;
  final VoidCallback? onProgress;
  final Duration duration;

  @override
  State<GameProgress> createState() => _GameProgressState();
}

class _GameProgressState extends State<GameProgress>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
    _animationController
      ..forward()
      ..addListener(() {
        widget.onProgress?.call();
        if (_animationController.isCompleted) {
          widget.onTimeOut.call();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PauseBloc, PauseState>(
      listener: (context, state) {
        if (state.isPaused) {
          _animationController.stop();
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            _animationController.forward();
          });
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return LinearProgressIndicator(
            value: 1 - _animationController.value,
            minHeight: 25,
            color: Colors.black26,
            backgroundColor: Colors.white24,
          );
        },
      ),
    );
  }
}

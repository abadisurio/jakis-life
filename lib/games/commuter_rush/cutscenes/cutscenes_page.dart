import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CommuterRushCutscenePage extends StatefulWidget {
  const CommuterRushCutscenePage({super.key, this.isWin = false});

  final bool isWin;

  @override
  State<CommuterRushCutscenePage> createState() =>
      _CommuterRushCutscenePageState();
}

class _CommuterRushCutscenePageState extends State<CommuterRushCutscenePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('isWin ${widget.isWin}'),
      ),
    );
  }
}

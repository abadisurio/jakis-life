import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CutScenePage extends StatefulWidget {
  const CutScenePage({
    required this.isWin,
    required this.previousPageName,
    super.key,
  });

  final bool isWin;
  final String previousPageName;

  @override
  State<CutScenePage> createState() => _CutScenePageState();
}

class _CutScenePageState extends State<CutScenePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          'isWin ${widget.isWin} previousPageName ${widget.previousPageName}',
        ),
      ),
    );
  }
}

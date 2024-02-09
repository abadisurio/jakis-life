import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/bloc/player_bloc.dart';
import 'package:katajakarta/router/katajakarta_route.dart';

@RoutePage()
class CutScenePage extends StatefulWidget {
  const CutScenePage({
    required this.isWin,
    super.key,
  });

  final bool isWin;

  @override
  State<CutScenePage> createState() => _CutScenePageState();
}

class _CutScenePageState extends State<CutScenePage> {
  String? currentGameName;
  @override
  void initState() {
    final bloc = context.read<PlayerBloc>();
    if (!widget.isWin) {
      bloc.add(const DecreaseLife());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        context.router.replace(const LifeCountRoute());
      });
    });
    currentGameName = bloc.state.currentGame;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          'isWin ${widget.isWin} previousPageName $currentGameName',
        ),
      ),
    );
  }
}

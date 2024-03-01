import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katajakarta/bloc/player_bloc.dart';
import 'package:katajakarta/gen/assets.gen.dart';
import 'package:rive/rive.dart';

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

  RiveGenImage? _cutSceneAnimation;

  @override
  void initState() {
    final bloc = context.read<PlayerBloc>()
      ..add(UpdateCurrentGameWin(isWin: widget.isWin));
    // _riveController = OneShotAnimation('Berhasil');
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(const Duration(seconds: 3), () {
    //     context.router.replace(const LifeCountRoute());
    //   });
    // });
    // Assets.rive.telorGulung.rive();
    currentGameName = bloc.state.currentGame;
    _cutSceneAnimation = _cutScene['TelorGulung'];
    // setState(() {
    //   _riveController.isActive = true;
    // });
    // _togglePlay();
    super.initState();
  }

  // void _togglePlay() {
  //   setState(() => _riveController.isActive = !_riveController.isActive);
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: _cutSceneAnimation?.rive(
          artboard: 'beli_telor_gulung',
          // animations: ['Berhasil'],
          // controllers: [_riveController],
          onInit: (Artboard artboard) {
            artboard.addController(SimpleAnimation('Timeline 1'));
            setState(() {});
          },
        ),
      ),
    );
  }
}

final _cutScene = {
  'TelorGulung': Assets.rive.jaki,
  // 'StableSidewalk': Assets.rive.telorGulung,
  // 'CommuterRush': Assets.rive.telorGulung,
  // 'LitterPicker': Assets.rive.telorGulung,
  // 'CollectSocket': Assets.rive.telorGulung,
};

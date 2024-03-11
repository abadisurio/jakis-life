import 'package:flutter/material.dart';
import 'package:jakislife/gen/assets.gen.dart';

class Passenger extends StatelessWidget {
  const Passenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 3,
      child: Assets.rive.jaki.rive(artboard: 'commuter_rush'),
    );
  }
}

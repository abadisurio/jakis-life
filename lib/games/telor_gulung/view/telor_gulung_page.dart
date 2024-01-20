import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TelorGulungPage extends StatelessWidget {
  const TelorGulungPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TelurGulungView();
  }
}

class _TelurGulungView extends StatefulWidget {
  const _TelurGulungView();

  @override
  State<_TelurGulungView> createState() => _TelurGulungViewState();
}

class _TelurGulungViewState extends State<_TelurGulungView> {
  double _prevAtan = 0;
  double _totalAngle = 0;
  static const double _radius = 80;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.shade100,
      child: Center(
        child: Transform.rotate(
          angle: _totalAngle % (2 * math.pi),
          child: GestureDetector(
            onPanUpdate: (dragUpdateDetails) {
              final atan = -math.atan2(
                _radius - dragUpdateDetails.localPosition.dx,
                _radius - dragUpdateDetails.localPosition.dy,
              );
              final difference =
                  (atan.isNegative ? 2 * math.pi + atan : atan) - _prevAtan;

              _totalAngle += difference.abs() > 6 ? 0 : difference;
              setState(() {
                _prevAtan = atan.isNegative ? 2 * math.pi + atan : atan;
              });
            },
            child: Container(
              height: _radius * 2,
              width: _radius * 2,
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child:
                    Text('text ${(_totalAngle * 180 / 3.14).roundToDouble()}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

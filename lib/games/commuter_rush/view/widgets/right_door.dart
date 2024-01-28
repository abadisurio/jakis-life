part of '../commuter_rush_page.dart';

class _CarDoorRight extends StatefulWidget {
  const _CarDoorRight();

  @override
  State<_CarDoorRight> createState() => _CarDoorRightState();
}

class _CarDoorRightState extends State<_CarDoorRight> {
  double _swipeOffset = 10;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 2), (timer) {
      if (_swipeOffset >= 0) {
        setState(() {
          _swipeOffset -= 0.1;
        });
        // timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: _swipeOffset,
      child: GestureDetector(
        onHorizontalDragUpdate: (detail) {
          log('detail $detail');
          if (_swipeOffset <= 75) {
            setState(() {
              _swipeOffset += detail.delta.dx / -4;
            });
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(right: 150),
          width: 225,
          child: const _DoorCase(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}

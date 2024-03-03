part of '../commuter_rush_page.dart';

class _CarDoorRight extends StatefulWidget {
  const _CarDoorRight();

  @override
  State<_CarDoorRight> createState() => _CarDoorRightState();
}

class _CarDoorRightState extends State<_CarDoorRight> {
  double _swipeOffset = 10;
  late Timer timer;
  late final _level = context.read<PlayerBloc>().state.point ~/ 200;
  final doorCase = const _DoorCase();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 2), (timer) {
      if (_swipeOffset >= 0) {
        setState(() {
          _swipeOffset -= 0.1;
        });
        context
            .read<CommuterRushBloc>()
            .add(SwipeRightDoor(swipeOffset: _swipeOffset));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: _swipeOffset.clamp(0, doorCase.width),
      child: GestureDetector(
        onHorizontalDragUpdate: (detail) {
          if (_swipeOffset <= 75) {
            setState(() {
              _swipeOffset += detail.delta.dx / -(1 + _level);
            });
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(right: 150),
          width: 225,
          child: doorCase,
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

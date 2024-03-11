part of '../commuter_rush_page.dart';

class _CarDoorLeft extends StatefulWidget {
  const _CarDoorLeft();

  @override
  State<_CarDoorLeft> createState() => _CarDoorLeftState();
}

class _CarDoorLeftState extends State<_CarDoorLeft> {
  double _swipeOffset = 10;
  late Timer timer;
  late final _level = context.read<PlayerBloc>().state.latestScore ~/ 200;
  final doorCase = const _DoorCase();

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 2), (timer) {
      if (_swipeOffset >= 0) {
        setState(() {
          _swipeOffset -= 0.1;
        });
        context
            .read<CommuterRushBloc>()
            .add(SwipeLeftDoor(swipeOffset: _swipeOffset));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _swipeOffset.clamp(0, doorCase.width),
      child: GestureDetector(
        onHorizontalDragUpdate: (detail) {
          if (_swipeOffset <= 75) {
            setState(() {
              _swipeOffset += detail.delta.dx / (1 + _level);
            });
            context
                .read<CommuterRushBloc>()
                .add(SwipeLeftDoor(swipeOffset: _swipeOffset));
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(left: 150),
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

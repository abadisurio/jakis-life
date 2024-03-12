part of 'battery_parry_page.dart';

class _Battery extends StatefulWidget {
  const _Battery({
    required this.onFlick,
    this.offset = Offset.zero,
  });

  final Offset offset;
  final VoidCallback onFlick;

  @override
  State<_Battery> createState() => _BatteryState();
}

class _BatteryState extends State<_Battery> with TickerProviderStateMixin {
  late final _level = context.read<PlayerBloc>().state.latestScore;
  static const _totalDuration = 5000;
  late final duration = (_totalDuration - _level * 2).clamp(1000, 5000);
  Offset? _flick;
  late final AnimationController _distanceController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: duration),
  );
  late final AnimationController _gravityController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: duration),
  );
  late final CurvedAnimation _distance = CurvedAnimation(
    parent: _distanceController,
    curve: Curves.easeOutCubic,
  );
  late final CurvedAnimation _gravity = CurvedAnimation(
    parent: _gravityController,
    curve: Curves.easeIn,
  );
  static const double _iconSize = 80;
  static const double _y = 100;
  double? _initialX;
  double? _initialY;
  double _x = 0;
  double _screenWidth = 0;

  @override
  void initState() {
    log('_distanceController ${_distanceController.duration}');
    _distanceController.forward();
    _gravityController.forward();
    _initialY = Random().nextInt(50) * 10 + 200.0;
    _gravityController.addListener(() {
      if ((_gravityController.value) >= 1) {
        _failGame();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenWidth = MediaQuery.of(context).size.width;
        _x = (_screenWidth - _iconSize) / 2;
        _initialX = (Random().nextBool() ? 0.7 : -0.7) * _screenWidth;
        _initialY =
            MediaQuery.of(context).size.height / (Random().nextInt(3) + 2);
      });
    });
    super.initState();
  }

  void _failGame() {
    _gravityController.stop();
    context.read<BatteryParryBloc>().add(const EndGame(isWin: false));
  }

  void _flickBattery(DragUpdateDetails detail) {
    if (_flick == null && detail.delta.dy <= -2) {
      _gravityController.stop();
      setState(() {
        _flick = detail.delta;
      });
      widget.onFlick.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialX == null || _initialY == null) {
      return const SizedBox.shrink();
    }
    return BlocListener<PauseBloc, PauseState>(
      listener: (context, state) {
        if (state.isPaused) {
          _distanceController.stop();
          _gravityController.stop();
        } else {
          _distanceController.forward();
          _gravityController.forward();
        }
      },
      listenWhen: (prev, curr) => prev.isPaused != curr.isPaused,
      child: AnimatedBuilder(
        animation: Listenable.merge([_distance, _gravity]),
        builder: (context, child) {
          return AnimatedPositioned(
            duration:
                _flick == null ? Duration.zero : const Duration(seconds: 1),
            bottom: widget.offset.dy +
                _y +
                _initialY! * (1 - _gravity.value) +
                _gravity.value +
                (_flick == null
                    ? 0
                    : _flick!.dy.clamp(-2, 0) * -_screenWidth * 2),
            left: widget.offset.dx +
                _x +
                _initialX! * (1 - _distance.value) +
                _distance.value +
                (_flick == null
                    ? 0
                    : _flick!.dx.clamp(-2, 2) * _screenWidth * 2),
            child: child!,
          );
        },
        child: GestureDetector(
          onPanUpdate: _flickBattery,
          child: SizedBox(
            height: _iconSize,
            width: _iconSize,
            child: Transform.rotate(
              angle: Random().nextDouble() * 2,
              child: Assets.svg.b3Battery.svg(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _gravityController.dispose();
    super.dispose();
  }
}

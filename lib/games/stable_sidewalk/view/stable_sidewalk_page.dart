import 'package:flutter/material.dart';

class StableSidewalkPage extends StatelessWidget {
  const StableSidewalkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SizedBox.fromSize(
        size: MediaQuery.of(context).size,
        child: Stack(
          children: [
            const Text('text'),
            const Text('text'),
            Center(
              child: Transform(
                // Transform widget
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.05) // perspective
                  ..rotateX(-0.2), // changed
                child: const _Sidewalk(),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('text'),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('text'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sidewalk extends StatefulWidget {
  const _Sidewalk();

  @override
  State<_Sidewalk> createState() => _SidewalkState();
}

class _SidewalkState extends State<_Sidewalk> with TickerProviderStateMixin {
  bool _dark = true;
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();

  @override
  void initState() {
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        setState(() {
          _dark = !_dark;
        });
        _animationController
          ..reset()
          ..forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const stripeCount = 50;
    const sidewalkHeight = 500.0;
    const stripeHeight = sidewalkHeight / (stripeCount * 2);
    return SizedBox(
      width: 40,
      height: sidewalkHeight,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Column(
                children: [
                  ...List.generate(stripeCount * 3, (index) {
                    if (index % 3 == 0) {
                      return Container(
                        color:
                            _dark ? Colors.grey.shade800 : Colors.grey.shade100,
                        height: stripeHeight * _animationController.value,
                      );
                    }
                    if (index % 3 == 2) {
                      return Container(
                        color:
                            _dark ? Colors.grey.shade800 : Colors.grey.shade100,
                        height: stripeHeight * (1 - _animationController.value),
                      );
                    }
                    return Container(
                      color:
                          _dark ? Colors.grey.shade100 : Colors.grey.shade800,
                      height: stripeHeight,
                    );
                  }),
                ],
              );
            },
          ),
          Positioned.fill(
            left: 10,
            right: 10,
            child: ColoredBox(color: Colors.grey.shade300),
          ),
        ],
      ),
    );
  }
}

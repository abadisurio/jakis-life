part of '../commuter_rush_page.dart';

class _DoorCase extends StatelessWidget {
  const _DoorCase();

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.red.shade200,
        BlendMode.srcOut,
      ),
      child: SizedBox(
        height: 180,
        width: 75,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
            ),
            Positioned(
              top: 25,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 50,
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

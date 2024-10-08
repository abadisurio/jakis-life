part of 'lobby_multiplayer_page.dart';

class _Card extends StatefulWidget {
  const _Card();

  static const double width = 300 * 1.2;
  static const double height = width * 4 / 3;

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> with TickerProviderStateMixin {
  double _swipeOffset = 0;
  bool _isSwiping = false;
  bool _isShowBack = false;

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  late final _curvedAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCirc,
  );

  late SvgGenImage badge;
  late Widget cardFront;
  late Widget cardBack;

  final badges = [
    Assets.svg.jakisBadge1,
    Assets.svg.jakisBadge2,
    Assets.svg.jakisBadge3,
  ];

  void _copyInvitation() {
    final url =
        'https://jakislife-dev.web.app/?start-multiplayer=${context.read<PlayerBloc>().state.user?.id}';
    Clipboard.setData(ClipboardData(text: url));
  }

  @override
  void initState() {
    final badgeSeries = context.read<PlayerBloc>().state.badgeSeries ?? 0;
    setState(() {
      badge = badges[badgeSeries];
      cardBack = _CardBack(
        background: badge.svg(),
      );
      cardFront = _CardFront(
        background: badge.svg(),
      );
    });
    _curvedAnimation.addListener(() {
      setState(() {
        _isShowBack = _curvedAnimation.value > 0.5;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _Card.height,
          width: _Card.width,
          child: GestureDetector(
            onHorizontalDragUpdate: (detail) {
              setState(() {
                _isSwiping = true;
                _swipeOffset += (detail.primaryDelta ?? 0) / 300;
                // _isShowBack = _swipeOffset > 0.5;
              });
              if (_swipeOffset > 0.5 && !_isShowBack) {
                setState(() {
                  _isShowBack = true;
                });
              } else if (_swipeOffset <= 0.5 && _isShowBack) {
                setState(() {
                  _isShowBack = false;
                });
              }
            },
            onHorizontalDragEnd: (detail) async {
              _animationController.value = _swipeOffset;
              setState(() {
                _isSwiping = false;
                _swipeOffset = _isShowBack ? 1 : 0;
              });
              if (_isShowBack) {
                await _animationController.forward();
              } else {
                await _animationController.reverse();
              }
            },
            child: Center(
              child: AnimatedBuilder(
                animation: _curvedAnimation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                        -pi *
                            (_isSwiping ? _swipeOffset : _curvedAnimation.value)
                                .clamp(-0.05, 1.05),
                      ),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                child: _isShowBack
                    ? Transform.flip(flipX: true, child: cardBack)
                    : cardFront,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KJButton(
              onPressed: () async {
                setState(() {
                  _isSwiping = false;
                  _swipeOffset = _isShowBack ? 0 : 1;
                });
                if (_isShowBack) {
                  await _animationController.reverse();
                } else {
                  await _animationController.forward();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See ',
                    style: TextStyleTheme(context)
                        .titleSmall
                        ?.copyWith(color: Colors.black),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCirc,
                    child: Text(
                      _isShowBack ? 'Badge' : 'QR',
                      style: TextStyleTheme(context)
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            KJButton(
              onPressed: _copyInvitation,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Copy Invitation Link',
                    style: TextStyleTheme(context)
                        .titleSmall
                        ?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

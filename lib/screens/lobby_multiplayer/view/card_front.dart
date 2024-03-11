part of 'lobby_multiplayer_page.dart';

class _CardFront extends StatelessWidget {
  const _CardFront({
    this.background,
  });

  final Widget? background;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (prev, curr) =>
          prev.authState != curr.authState ||
          prev.latestScore != curr.latestScore,
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            color: Colors.teal.shade800,
            height: _Card.height,
            width: _Card.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (background != null) background!,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      foregroundImage: CachedNetworkImageProvider(
                        state.currentUser?.photoURL ??
                            'https://picsum.photos/200',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.currentUser?.displayName ?? 'Jaki',
                      style: TextStyleTheme(context)
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      '${PlayerState.minimumHighScore} score finisher',
                      style: TextStyleTheme(context)
                          .titleSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 250),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

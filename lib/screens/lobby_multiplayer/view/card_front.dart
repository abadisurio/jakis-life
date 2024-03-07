part of 'lobby_multiplayer_page.dart';

class _CardFront extends StatelessWidget {
  const _CardFront();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (prev, curr) =>
          prev.isSignedIn != curr.isSignedIn || prev.point != curr.point,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.teal.shade800,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(32),
          height: _Card.height,
          width: _Card.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 96,
                foregroundImage: CachedNetworkImageProvider(
                  state.currentUser?.photoURL ?? 'https://picsum.photos/200',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                state.currentUser?.displayName ?? 'Jaki',
                style: TextStyleTheme(context)
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Top Score',
                style: TextStyleTheme(context)
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              Text(
                '${state.point}',
                style: TextStyleTheme(context)
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}

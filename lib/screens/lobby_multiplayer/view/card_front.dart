part of 'lobby_multiplayer_page.dart';

class _CardFront extends StatelessWidget {
  const _CardFront();

  @override
  Widget build(BuildContext context) {
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
          const CircleAvatar(
            radius: 96,
            foregroundImage:
                CachedNetworkImageProvider('https://picsum.photos/200'),
          ),
          const SizedBox(height: 16),
          Text(
            'Abadi Suryo',
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
            '3.600',
            style: TextStyleTheme(context)
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

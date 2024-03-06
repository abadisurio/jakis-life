part of 'lobby_multiplayer_page.dart';

class _CardFront extends StatefulWidget {
  const _CardFront();

  @override
  State<_CardFront> createState() => _CardFrontState();
}

class _CardFrontState extends State<_CardFront> {
  User? _currentUser;

  @override
  void initState() {
    _currentUser = context.read<PlayerBloc>().state.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) {
        log('called');
        setState(() {
          _currentUser = state.currentUser;
        });
      },
      listenWhen: (prev, curr) => prev.isSignedIn != curr.isSignedIn,
      child: Container(
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
                _currentUser?.photoURL ?? 'https://picsum.photos/200',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _currentUser?.displayName ?? 'Jaki',
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
      ),
    );
  }
}

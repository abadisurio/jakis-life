import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/shared/bloc/player_bloc/player_bloc.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard({super.key});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        type: MaterialType.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCirc,
          child: BlocBuilder<PlayerBloc, PlayerState>(
            buildWhen: (prev, curr) => prev.authState != curr.authState,
            builder: (context, state) {
              log('authState ${state.authState}');
              if (state.authState == AuthState.loading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: CircularProgressIndicator(),
                );
              }
              if (state.authState == AuthState.signedOut) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Sign in to save your high score and play with friends',
                          style: TextStyleTheme(context).bodyMedium,
                        ),
                      ),
                      const SizedBox(width: 32),
                      KJButton(
                        onPressed: () {
                          context.read<PlayerBloc>().add(const PlayerSignIn());
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyleTheme(context)
                              .titleSmall
                              ?.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListTile(
                // dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  '${state.currentUser?.displayName}',
                  style: TextStyleTheme(context).bodyMedium,
                ),
                subtitle: Text('High Score: ${state.highScore}'),
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    '${state.currentUser?.photoURL}',
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.output_rounded),
                  onPressed: () {
                    context.read<PlayerBloc>().add(const PlayerSignOut());
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

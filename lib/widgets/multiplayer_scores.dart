import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/model/model.dart';
import 'package:jakislife/shared/bloc/multiplayer_bloc/multiplayer_bloc.dart';
import 'package:jakislife/utils/text_theme.dart';

class MultiplayerScores extends StatefulWidget {
  const MultiplayerScores({super.key});

  @override
  State<MultiplayerScores> createState() => _MultiplayerScoresState();
}

class _MultiplayerScoresState extends State<MultiplayerScores> {
  List<JakisLifePlayer>? _mpPlayers;
  JakisLifePlayer? _mpSelf;
  MultiplayerState? _mpState;
  @override
  void initState() {
    _mpState = context.read<MultiplayerBloc>().state;
    if (_mpState?.challengeId != null) {
      setState(() {
        _mpPlayers = [..._mpState?.players ?? []];
        _mpSelf = _mpState?.self;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _mpPlayers?.sort(
      (prev, curr) => (curr.highScore ?? 0).compareTo(prev.highScore ?? 0),
    );
    if (_mpPlayers == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // color: Colors.red,
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _mpPlayers?.length ?? 0,
        itemBuilder: (context, index) {
          final player = _mpPlayers![index];
          // final player = JakisLifePlayer(
          //   id: 'id',
          //   displayName: 'nama',
          //   highScore: 3043,
          //   photoUrl: 'https://www.gstatic.com/webp/gallery/1.jpg',
          // );
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('${index + 1}'),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 8, right: 32),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        player.photoUrl ??
                            'https://www.gstatic.com/webp/gallery/1.jpg',
                      ),
                    ),
                    title: Text(
                      player.displayName ?? 'Player ${index + 1}',
                      style: player.id != _mpSelf?.id
                          ? null
                          : TextStyleTheme(context).titleSmall,
                    ),
                    trailing: Text(
                      '${player.highScore}',
                      style: TextStyleTheme(context).bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

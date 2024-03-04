import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

part 'card.dart';
part 'card_back.dart';
part 'card_front.dart';

@RoutePage()
class LobbyMultiplayerPage extends StatelessWidget {
  const LobbyMultiplayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LobbyMultiplayerView();
  }
}

class _LobbyMultiplayerView extends StatelessWidget {
  const _LobbyMultiplayerView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Play with your friends!'),
      ),
      backgroundColor: Colors.blue.shade100,
      body: ListView(
        children: const [SizedBox(height: 32), _Card()],
      ),
    );
  }
}

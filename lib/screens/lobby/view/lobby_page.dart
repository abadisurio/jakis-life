import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jakislife/app/app.dart';
import 'package:jakislife/gen/assets.gen.dart';
import 'package:jakislife/router/router.dart';
import 'package:jakislife/utils/text_theme.dart';
import 'package:jakislife/widgets/widgets.dart';

@RoutePage()
class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LobbyView();
  }
}

class _LobbyView extends StatelessWidget {
  const _LobbyView();

  // @override
  // Widget build(BuildContext context) {
  //   return LifeCountPage();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        final invitedId = state.appLinkQuery?['start-multiplayer'];
        log('invitedId $invitedId');
        context.router.push(LobbyMultiplayerRoute(invitedId: invitedId));
      },
      listenWhen: (prev, curr) {
        log('curr $curr');
        return curr.appLinkQuery?.containsKey('start-multiplayer') ?? false;
      },
      child: Material(
        color: Colors.blue.shade100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Assets.rive.jaki.rive(
              artboard: 'home',
              fit: BoxFit.cover,
            ),
            Assets.svg.jakisTitle.svg(width: 300),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KJButton(
                      onPressed: () {
                        context.router.push(const GameRandomizerRoute());
                      },
                      child: Text(
                        "Let's go!",
                        style: TextStyleTheme(context)
                            .titleLarge
                            ?.copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KJButton(
                          onPressed: () {
                            context.router.push(
                              LobbyMultiplayerRoute(),
                            );
                          },
                          child: Text(
                            'Multiplayer',
                            style: TextStyleTheme(context)
                                .titleSmall
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const BacksoundPauseButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: PlayerCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

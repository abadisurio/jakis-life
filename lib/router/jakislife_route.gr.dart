// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:jakislife/games/game_randomizer_page.dart' as _i4;
import 'package:jakislife/screens/badge/view/badge_page.dart' as _i1;
import 'package:jakislife/screens/cutscenes/cutscenes_page.dart' as _i2;
import 'package:jakislife/screens/game_end/view/game_end_page.dart' as _i3;
import 'package:jakislife/screens/life_count/view/life_count_page.dart' as _i5;
import 'package:jakislife/screens/lobby/view/lobby_page.dart' as _i7;
import 'package:jakislife/screens/lobby_multiplayer/view/lobby_multiplayer_page.dart'
    as _i6;
import 'package:jakislife/screens/pause/view/pause_page.dart' as _i8;
import 'package:jakislife/screens/win/view/win_page.dart' as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    BadgeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BadgePage(),
      );
    },
    CutSceneRoute.name: (routeData) {
      final args = routeData.argsAs<CutSceneRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CutScenePage(
          isWin: args.isWin,
          key: args.key,
        ),
      );
    },
    GameEndRoute.name: (routeData) {
      final args = routeData.argsAs<GameEndRouteArgs>(
          orElse: () => const GameEndRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GameEndPage(
          key: args.key,
          showBadge: args.showBadge,
        ),
      );
    },
    GameRandomizerRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.GameRandomizerPage(),
      );
    },
    LifeCountRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LifeCountPage(),
      );
    },
    LobbyMultiplayerRoute.name: (routeData) {
      final args = routeData.argsAs<LobbyMultiplayerRouteArgs>(
          orElse: () => const LobbyMultiplayerRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.LobbyMultiplayerPage(
          key: args.key,
          invitedId: args.invitedId,
          challengeId: args.challengeId,
        ),
      );
    },
    LobbyRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LobbyPage(),
      );
    },
    PauseRoute.name: (routeData) {
      return _i10.AutoRoutePage<bool?>(
        routeData: routeData,
        child: const _i8.PausePage(),
      );
    },
    WinRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.WinPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BadgePage]
class BadgeRoute extends _i10.PageRouteInfo<void> {
  const BadgeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          BadgeRoute.name,
          initialChildren: children,
        );

  static const String name = 'BadgeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CutScenePage]
class CutSceneRoute extends _i10.PageRouteInfo<CutSceneRouteArgs> {
  CutSceneRoute({
    required bool isWin,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CutSceneRoute.name,
          args: CutSceneRouteArgs(
            isWin: isWin,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CutSceneRoute';

  static const _i10.PageInfo<CutSceneRouteArgs> page =
      _i10.PageInfo<CutSceneRouteArgs>(name);
}

class CutSceneRouteArgs {
  const CutSceneRouteArgs({
    required this.isWin,
    this.key,
  });

  final bool isWin;

  final _i11.Key? key;

  @override
  String toString() {
    return 'CutSceneRouteArgs{isWin: $isWin, key: $key}';
  }
}

/// generated route for
/// [_i3.GameEndPage]
class GameEndRoute extends _i10.PageRouteInfo<GameEndRouteArgs> {
  GameEndRoute({
    _i11.Key? key,
    bool? showBadge = false,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          GameEndRoute.name,
          args: GameEndRouteArgs(
            key: key,
            showBadge: showBadge,
          ),
          initialChildren: children,
        );

  static const String name = 'GameEndRoute';

  static const _i10.PageInfo<GameEndRouteArgs> page =
      _i10.PageInfo<GameEndRouteArgs>(name);
}

class GameEndRouteArgs {
  const GameEndRouteArgs({
    this.key,
    this.showBadge = false,
  });

  final _i11.Key? key;

  final bool? showBadge;

  @override
  String toString() {
    return 'GameEndRouteArgs{key: $key, showBadge: $showBadge}';
  }
}

/// generated route for
/// [_i4.GameRandomizerPage]
class GameRandomizerRoute extends _i10.PageRouteInfo<void> {
  const GameRandomizerRoute({List<_i10.PageRouteInfo>? children})
      : super(
          GameRandomizerRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRandomizerRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LifeCountPage]
class LifeCountRoute extends _i10.PageRouteInfo<void> {
  const LifeCountRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LifeCountRoute.name,
          initialChildren: children,
        );

  static const String name = 'LifeCountRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LobbyMultiplayerPage]
class LobbyMultiplayerRoute
    extends _i10.PageRouteInfo<LobbyMultiplayerRouteArgs> {
  LobbyMultiplayerRoute({
    _i11.Key? key,
    String? invitedId,
    String? challengeId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          LobbyMultiplayerRoute.name,
          args: LobbyMultiplayerRouteArgs(
            key: key,
            invitedId: invitedId,
            challengeId: challengeId,
          ),
          initialChildren: children,
        );

  static const String name = 'LobbyMultiplayerRoute';

  static const _i10.PageInfo<LobbyMultiplayerRouteArgs> page =
      _i10.PageInfo<LobbyMultiplayerRouteArgs>(name);
}

class LobbyMultiplayerRouteArgs {
  const LobbyMultiplayerRouteArgs({
    this.key,
    this.invitedId,
    this.challengeId,
  });

  final _i11.Key? key;

  final String? invitedId;

  final String? challengeId;

  @override
  String toString() {
    return 'LobbyMultiplayerRouteArgs{key: $key, invitedId: $invitedId, challengeId: $challengeId}';
  }
}

/// generated route for
/// [_i7.LobbyPage]
class LobbyRoute extends _i10.PageRouteInfo<void> {
  const LobbyRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PausePage]
class PauseRoute extends _i10.PageRouteInfo<void> {
  const PauseRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PauseRoute.name,
          initialChildren: children,
        );

  static const String name = 'PauseRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.WinPage]
class WinRoute extends _i10.PageRouteInfo<void> {
  const WinRoute({List<_i10.PageRouteInfo>? children})
      : super(
          WinRoute.name,
          initialChildren: children,
        );

  static const String name = 'WinRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

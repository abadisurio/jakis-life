// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:jakislife/games/game_randomizer_page.dart' as _i3;
import 'package:jakislife/screens/cutscenes/cutscenes_page.dart' as _i1;
import 'package:jakislife/screens/game_end/view/game_end_page.dart' as _i2;
import 'package:jakislife/screens/life_count/view/life_count_page.dart' as _i4;
import 'package:jakislife/screens/lobby/view/lobby_page.dart' as _i5;
import 'package:jakislife/screens/pause/view/pause_page.dart' as _i6;
import 'package:jakislife/screens/win/view/win_page.dart' as _i7;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    CutSceneRoute.name: (routeData) {
      final args = routeData.argsAs<CutSceneRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CutScenePage(
          isWin: args.isWin,
          key: args.key,
        ),
      );
    },
    GameEndRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GameEndPage(),
      );
    },
    GameRandomizerRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GameRandomizerPage(),
      );
    },
    LifeCountRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LifeCountPage(),
      );
    },
    LobbyRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LobbyPage(),
      );
    },
    PauseRoute.name: (routeData) {
      return _i8.AutoRoutePage<bool?>(
        routeData: routeData,
        child: const _i6.PausePage(),
      );
    },
    WinRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.WinPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CutScenePage]
class CutSceneRoute extends _i8.PageRouteInfo<CutSceneRouteArgs> {
  CutSceneRoute({
    required bool isWin,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          CutSceneRoute.name,
          args: CutSceneRouteArgs(
            isWin: isWin,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CutSceneRoute';

  static const _i8.PageInfo<CutSceneRouteArgs> page =
      _i8.PageInfo<CutSceneRouteArgs>(name);
}

class CutSceneRouteArgs {
  const CutSceneRouteArgs({
    required this.isWin,
    this.key,
  });

  final bool isWin;

  final _i9.Key? key;

  @override
  String toString() {
    return 'CutSceneRouteArgs{isWin: $isWin, key: $key}';
  }
}

/// generated route for
/// [_i2.GameEndPage]
class GameEndRoute extends _i8.PageRouteInfo<void> {
  const GameEndRoute({List<_i8.PageRouteInfo>? children})
      : super(
          GameEndRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameEndRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GameRandomizerPage]
class GameRandomizerRoute extends _i8.PageRouteInfo<void> {
  const GameRandomizerRoute({List<_i8.PageRouteInfo>? children})
      : super(
          GameRandomizerRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRandomizerRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LifeCountPage]
class LifeCountRoute extends _i8.PageRouteInfo<void> {
  const LifeCountRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LifeCountRoute.name,
          initialChildren: children,
        );

  static const String name = 'LifeCountRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LobbyPage]
class LobbyRoute extends _i8.PageRouteInfo<void> {
  const LobbyRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PausePage]
class PauseRoute extends _i8.PageRouteInfo<void> {
  const PauseRoute({List<_i8.PageRouteInfo>? children})
      : super(
          PauseRoute.name,
          initialChildren: children,
        );

  static const String name = 'PauseRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.WinPage]
class WinRoute extends _i8.PageRouteInfo<void> {
  const WinRoute({List<_i8.PageRouteInfo>? children})
      : super(
          WinRoute.name,
          initialChildren: children,
        );

  static const String name = 'WinRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

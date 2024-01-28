// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:katajakarta/games/commuter_rush/view/commuter_rush_page.dart'
    as _i1;
import 'package:katajakarta/games/stable_sidewalk/view/stable_sidewalk_page.dart'
    as _i6;
import 'package:katajakarta/games/telor_gulung/view/telor_gulung_page.dart'
    as _i7;
import 'package:katajakarta/screens/cutscenes/cutscenes_page.dart' as _i2;
import 'package:katajakarta/screens/lobby/view/lobby_page.dart' as _i3;
import 'package:katajakarta/screens/lost/view/lost_page.dart' as _i4;
import 'package:katajakarta/screens/pause/view/pause_page.dart' as _i5;
import 'package:katajakarta/screens/win/view/win_page.dart' as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CommuterRushRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CommuterRushPage(),
      );
    },
    CutSceneRoute.name: (routeData) {
      final args = routeData.argsAs<CutSceneRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CutScenePage(
          isWin: args.isWin,
          previousPageName: args.previousPageName,
          key: args.key,
        ),
      );
    },
    LobbyRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LobbyPage(),
      );
    },
    LostRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LostPage(),
      );
    },
    PauseRoute.name: (routeData) {
      return _i9.AutoRoutePage<bool?>(
        routeData: routeData,
        child: const _i5.PausePage(),
      );
    },
    StableSidewalkRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.StableSidewalkPage(),
      );
    },
    TelorGulungRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.TelorGulungPage(),
      );
    },
    WinRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.WinPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CommuterRushPage]
class CommuterRushRoute extends _i9.PageRouteInfo<void> {
  const CommuterRushRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CommuterRushRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommuterRushRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CutScenePage]
class CutSceneRoute extends _i9.PageRouteInfo<CutSceneRouteArgs> {
  CutSceneRoute({
    required bool isWin,
    required String previousPageName,
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          CutSceneRoute.name,
          args: CutSceneRouteArgs(
            isWin: isWin,
            previousPageName: previousPageName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CutSceneRoute';

  static const _i9.PageInfo<CutSceneRouteArgs> page =
      _i9.PageInfo<CutSceneRouteArgs>(name);
}

class CutSceneRouteArgs {
  const CutSceneRouteArgs({
    required this.isWin,
    required this.previousPageName,
    this.key,
  });

  final bool isWin;

  final String previousPageName;

  final _i10.Key? key;

  @override
  String toString() {
    return 'CutSceneRouteArgs{isWin: $isWin, previousPageName: $previousPageName, key: $key}';
  }
}

/// generated route for
/// [_i3.LobbyPage]
class LobbyRoute extends _i9.PageRouteInfo<void> {
  const LobbyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LostPage]
class LostRoute extends _i9.PageRouteInfo<void> {
  const LostRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LostRoute.name,
          initialChildren: children,
        );

  static const String name = 'LostRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PausePage]
class PauseRoute extends _i9.PageRouteInfo<void> {
  const PauseRoute({List<_i9.PageRouteInfo>? children})
      : super(
          PauseRoute.name,
          initialChildren: children,
        );

  static const String name = 'PauseRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.StableSidewalkPage]
class StableSidewalkRoute extends _i9.PageRouteInfo<void> {
  const StableSidewalkRoute({List<_i9.PageRouteInfo>? children})
      : super(
          StableSidewalkRoute.name,
          initialChildren: children,
        );

  static const String name = 'StableSidewalkRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.TelorGulungPage]
class TelorGulungRoute extends _i9.PageRouteInfo<void> {
  const TelorGulungRoute({List<_i9.PageRouteInfo>? children})
      : super(
          TelorGulungRoute.name,
          initialChildren: children,
        );

  static const String name = 'TelorGulungRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.WinPage]
class WinRoute extends _i9.PageRouteInfo<void> {
  const WinRoute({List<_i9.PageRouteInfo>? children})
      : super(
          WinRoute.name,
          initialChildren: children,
        );

  static const String name = 'WinRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:katajakarta/games/commuter_rush/view/commuter_rush_page.dart'
    as _i1;
import 'package:katajakarta/games/stable_sidewalk/view/stable_sidewalk_page.dart'
    as _i5;
import 'package:katajakarta/games/telor_gulung/view/telor_gulung_page.dart'
    as _i6;
import 'package:katajakarta/screens/lobby/view/lobby_page.dart' as _i2;
import 'package:katajakarta/screens/lost/view/lost_page.dart' as _i3;
import 'package:katajakarta/screens/pause/view/pause_page.dart' as _i4;
import 'package:katajakarta/screens/win/view/win_page.dart' as _i7;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    CommuterRushRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CommuterRushPage(),
      );
    },
    LobbyRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LobbyPage(),
      );
    },
    LostRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LostPage(),
      );
    },
    PauseRoute.name: (routeData) {
      return _i8.AutoRoutePage<bool?>(
        routeData: routeData,
        child: const _i4.PausePage(),
      );
    },
    StableSidewalkRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.StableSidewalkPage(),
      );
    },
    TelorGulungRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.TelorGulungPage(),
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
/// [_i1.CommuterRushPage]
class CommuterRushRoute extends _i8.PageRouteInfo<void> {
  const CommuterRushRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CommuterRushRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommuterRushRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LobbyPage]
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
/// [_i3.LostPage]
class LostRoute extends _i8.PageRouteInfo<void> {
  const LostRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LostRoute.name,
          initialChildren: children,
        );

  static const String name = 'LostRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PausePage]
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
/// [_i5.StableSidewalkPage]
class StableSidewalkRoute extends _i8.PageRouteInfo<void> {
  const StableSidewalkRoute({List<_i8.PageRouteInfo>? children})
      : super(
          StableSidewalkRoute.name,
          initialChildren: children,
        );

  static const String name = 'StableSidewalkRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.TelorGulungPage]
class TelorGulungRoute extends _i8.PageRouteInfo<void> {
  const TelorGulungRoute({List<_i8.PageRouteInfo>? children})
      : super(
          TelorGulungRoute.name,
          initialChildren: children,
        );

  static const String name = 'TelorGulungRoute';

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

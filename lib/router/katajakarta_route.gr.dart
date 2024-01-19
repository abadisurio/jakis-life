// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:katajakarta/games/stable_sidewalk/view/stable_sidewalk_page.dart'
    as _i4;
import 'package:katajakarta/screens/lobby/view/lobby_page.dart' as _i1;
import 'package:katajakarta/screens/lost/view/lost_page.dart' as _i2;
import 'package:katajakarta/screens/pause/view/pause_page.dart' as _i3;
import 'package:katajakarta/screens/win/view/win_page.dart' as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    LobbyRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LobbyPage(),
      );
    },
    LostRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LostPage(),
      );
    },
    PauseRoute.name: (routeData) {
      return _i6.AutoRoutePage<bool?>(
        routeData: routeData,
        child: const _i3.PausePage(),
      );
    },
    StableSidewalkRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.StableSidewalkPage(),
      );
    },
    WinRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.WinPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.LobbyPage]
class LobbyRoute extends _i6.PageRouteInfo<void> {
  const LobbyRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LostPage]
class LostRoute extends _i6.PageRouteInfo<void> {
  const LostRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LostRoute.name,
          initialChildren: children,
        );

  static const String name = 'LostRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PausePage]
class PauseRoute extends _i6.PageRouteInfo<void> {
  const PauseRoute({List<_i6.PageRouteInfo>? children})
      : super(
          PauseRoute.name,
          initialChildren: children,
        );

  static const String name = 'PauseRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.StableSidewalkPage]
class StableSidewalkRoute extends _i6.PageRouteInfo<void> {
  const StableSidewalkRoute({List<_i6.PageRouteInfo>? children})
      : super(
          StableSidewalkRoute.name,
          initialChildren: children,
        );

  static const String name = 'StableSidewalkRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.WinPage]
class WinRoute extends _i6.PageRouteInfo<void> {
  const WinRoute({List<_i6.PageRouteInfo>? children})
      : super(
          WinRoute.name,
          initialChildren: children,
        );

  static const String name = 'WinRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

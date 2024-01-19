// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:katajakarta/games/stable_sidewalk/view/stable_sidewalk_page.dart'
    as _i3;
import 'package:katajakarta/screens/lobby/view/lobby_page.dart' as _i1;
import 'package:katajakarta/screens/pause/view/pause_page.dart' as _i2;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LobbyRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LobbyPage(),
      );
    },
    PauseRoute.name: (routeData) {
      return _i4.AutoRoutePage<bool?>(
        routeData: routeData,
        child: const _i2.PausePage(),
      );
    },
    StableSidewalkRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.StableSidewalkPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.LobbyPage]
class LobbyRoute extends _i4.PageRouteInfo<void> {
  const LobbyRoute({List<_i4.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PausePage]
class PauseRoute extends _i4.PageRouteInfo<void> {
  const PauseRoute({List<_i4.PageRouteInfo>? children})
      : super(
          PauseRoute.name,
          initialChildren: children,
        );

  static const String name = 'PauseRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.StableSidewalkPage]
class StableSidewalkRoute extends _i4.PageRouteInfo<void> {
  const StableSidewalkRoute({List<_i4.PageRouteInfo>? children})
      : super(
          StableSidewalkRoute.name,
          initialChildren: children,
        );

  static const String name = 'StableSidewalkRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

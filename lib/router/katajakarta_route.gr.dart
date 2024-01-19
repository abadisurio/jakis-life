// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:katajakarta/games/stable_sidewalk/view/stable_sidewalk_page.dart'
    as _i2;
import 'package:katajakarta/screens/lobby/view/lobby_page.dart' as _i1;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    LobbyRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LobbyPage(),
      );
    },
    StableSidewalkRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.StableSidewalkPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.LobbyPage]
class LobbyRoute extends _i3.PageRouteInfo<void> {
  const LobbyRoute({List<_i3.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.StableSidewalkPage]
class StableSidewalkRoute extends _i3.PageRouteInfo<void> {
  const StableSidewalkRoute({List<_i3.PageRouteInfo>? children})
      : super(
          StableSidewalkRoute.name,
          initialChildren: children,
        );

  static const String name = 'StableSidewalkRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

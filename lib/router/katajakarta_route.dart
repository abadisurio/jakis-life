import 'package:auto_route/auto_route.dart';
import 'package:katajakarta/router/katajakarta_route.gr.dart';

export 'katajakarta_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LobbyRoute.page,
          initial: true,
        ),
        CustomRoute(
          page: GameRandomizerRoute.page,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        CustomRoute(
          page: PauseRoute.page,
          fullscreenDialog: true,
          opaque: false,
          durationInMilliseconds: 0,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: CutSceneRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: LifeCountRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        AutoRoute(
          page: WinRoute.page,
        ),
        AutoRoute(
          page: GameEndRoute.page,
        ),
      ];
}

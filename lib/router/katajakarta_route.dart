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
        ),
        AutoRoute(
          page: StableSidewalkRoute.page,
        ),
        AutoRoute(
          page: TelorGulungRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: CommuterRushRoute.page,
        ),
        CustomRoute(
          page: PauseRoute.page,
          fullscreenDialog: true,
          opaque: false,
          durationInMilliseconds: 0,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: CutSceneRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        AutoRoute(
          page: WinRoute.page,
        ),
        AutoRoute(
          page: LostRoute.page,
        ),
      ];
}

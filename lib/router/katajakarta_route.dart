import 'package:auto_route/auto_route.dart';
import 'package:katajakarta/router/katajakarta_route.gr.dart';

export 'katajakarta_route.gr.dart';

@AutoRouterConfig()
class KataJakartaRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LobbyRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: StableSidewalkRoute.page,
        ),
      ];
}

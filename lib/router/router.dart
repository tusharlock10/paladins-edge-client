import 'package:go_router/go_router.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;

final _loadoutsRoutes = [
  screens.CreateLoadout.goRoute,
];

final _championDetailRoutes = [
  screens.Loadouts.goRouteBuilder(_loadoutsRoutes),
];

final _playerDetailRoutes = [
  screens.PlayerChampions.goRoute,
  screens.Friends.goRoute,
  screens.MatchDetail.goRoute,
  screens.ActiveMatch.goRoute,
];

final _mainRoutes = [
  screens.ChampionDetail.goRouteBuilder(_championDetailRoutes),
  screens.PlayerDetail.goRouteBuilder(_playerDetailRoutes),
  screens.Friends.userGoRoute,
  screens.ActiveMatch.userGoRoute,
  screens.Feedback.goRoute,
];

String? _routeRedirect(GoRouterState _) {
  if (utilities.Global.isAuthenticated && !utilities.Global.isPlayerConnected) {
    return screens.ConnectProfile.routePath;
  }

  return null;
}

final router = GoRouter(
  errorBuilder: screens.NotFound.routeBuilder,
  debugLogDiagnostics: constants.isDebug,
  initialLocation: screens.Main.routePath,
  urlPathStrategy: UrlPathStrategy.path,
  redirect: _routeRedirect,
  routes: [
    screens.Login.goRoute,
    screens.ConnectProfile.goRoute,
    screens.Main.goRouteBuilder(_mainRoutes),
  ],
);

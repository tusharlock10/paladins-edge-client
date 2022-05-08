import 'package:go_router/go_router.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/screens/index.dart' as screens;

final _loadoutsRoutes = [
  screens.CreateLoadout.goRoute,
];

final _championDetailRoutes = [
  screens.Loadouts.goRouteBuilder(_loadoutsRoutes),
];

final _mainRoutes = [
  screens.Login.goRoute,
  screens.ChampionDetail.goRouteBuilder(_championDetailRoutes),
  screens.PlayerDetail.goRoute,
  screens.ConnectProfile.goRoute,
  screens.Friends.goRoute,
  screens.MatchDetail.goRoute,
  screens.ActiveMatch.goRoute,
  screens.PlayerChampions.goRoute,
  screens.Feedback.goRoute,
];

final router = GoRouter(
  errorBuilder: screens.NotFound.routeBuilder,
  debugLogDiagnostics: constants.isDebug,
  initialLocation: screens.Main.routePath,
  urlPathStrategy: UrlPathStrategy.hash,
  routes: [screens.Main.goRouteBuilder(_mainRoutes)],
);

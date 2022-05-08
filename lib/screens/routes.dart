import 'package:beamer/beamer.dart';
import 'package:paladinsedge/screens/index.dart' as screens;

/// Each screen will expose 2 functions
/// 1) routeBuilder: (context, state, data) => screen()
/// 2) navigate: () => context.beamTo(screen)

final routes = {
  screens.Main.routeName: screens.Main.routeBuilder,
  screens.Main.routeSearchName: screens.Main.routeBuilder,
  screens.Main.routeChampionsName: screens.Main.routeBuilder,
  screens.Login.routeName: screens.Login.routeBuilder,
  screens.ChampionDetail.routeName: screens.ChampionDetail.routeBuilder,
  screens.PlayerDetail.routeName: screens.PlayerDetail.routeBuilder,
  screens.ConnectProfile.routeName: screens.ConnectProfile.routeBuilder,
  screens.Home.routeName: screens.Home.routeBuilder,
  screens.Friends.routeName: screens.Friends.routeBuilder,
  screens.MatchDetail.routeName: screens.MatchDetail.routeBuilder,
  screens.ActiveMatch.routeName: screens.ActiveMatch.routeBuilder,
  screens.Loadouts.routeName: screens.Loadouts.routeBuilder,
  screens.CreateLoadout.routeName: screens.CreateLoadout.routeBuilder,
  screens.PlayerChampions.routeName: screens.PlayerChampions.routeBuilder,
  screens.Feedback.routeName: screens.Feedback.routeBuilder,
};

final routerDelegate = BeamerDelegate(
  initialPath: screens.Login.routeName,
  notFoundPage: screens.NotFound.page,
  locationBuilder: RoutesLocationBuilder(
    routes: routes,
  ),
);

import 'package:beamer/beamer.dart';
import 'package:paladinsedge/screens/index.dart' as screens;

/// Each screen will expose 2 functions
/// 1) routeBuilder: (context, state, data) => screen()
/// 2) navigate: () => context.beamTo(screen)

final routes = {
  screens.Login.routeName: (_, __, ___) => const screens.Login(),
  screens.Main.routeName: (_, __, ___) => const screens.Main(),
  screens.Search.routeName: (_, __, ___) => const screens.Search(),
  screens.Champions.routeName: (_, __, ___) => const screens.Champions(),
  screens.ChampionDetail.routeName: (_, __, ___) =>
      const screens.ChampionDetail(),
  screens.PlayerDetail.routeName: (_, __, ___) => const screens.PlayerDetail(),
  screens.ConnectProfile.routeName: (_, __, ___) =>
      const screens.ConnectProfile(),
  screens.Home.routeName: (_, __, ___) => const screens.Home(),
  screens.Friends.routeName: (_, __, ___) => screens.Friends(),
  screens.MatchDetail.routeName: (_, __, ___) => const screens.MatchDetail(),
  screens.ActiveMatch.routeName: (_, __, ___) => const screens.ActiveMatch(),
  screens.Loadouts.routeName: (_, __, ___) => const screens.Loadouts(),
  screens.CreateLoadout.routeName: (_, __, ___) =>
      const screens.CreateLoadout(),
  screens.PlayerChampions.routeName: (_, __, ___) =>
      const screens.PlayerChampions(),
  screens.Feedback.routeName: (_, __, ___) => const screens.Feedback(),
};

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: routes,
  ),
);

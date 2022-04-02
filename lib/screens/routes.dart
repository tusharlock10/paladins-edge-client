import 'package:paladinsedge/screens/index.dart' as screens;

final routes = {
  screens.Login.routeName: (_) => const screens.Login(),
  screens.BottomTabs.routeName: (_) => screens.BottomTabs(),
  screens.Search.routeName: (_) => const screens.Search(),
  screens.Champions.routeName: (_) => const screens.Champions(),
  screens.ChampionDetail.routeName: (_) => const screens.ChampionDetail(),
  screens.PlayerDetail.routeName: (_) => const screens.PlayerDetail(),
  screens.ConnectProfile.routeName: (_) => const screens.ConnectProfile(),
  screens.Home.routeName: (_) => const screens.Home(),
  screens.Friends.routeName: (_) => screens.Friends(),
  screens.MatchDetail.routeName: (_) => const screens.MatchDetail(),
  screens.ActiveMatch.routeName: (_) => const screens.ActiveMatch(),
  screens.Loadouts.routeName: (_) => const screens.Loadouts(),
  screens.CreateLoadout.routeName: (_) => const screens.CreateLoadout(),
  screens.PlayerChampions.routeName: (_) => const screens.PlayerChampions(),
  screens.Feedback.routeName: (_) => const screens.Feedback(),
};

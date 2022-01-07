import 'package:paladinsedge/screens/index.dart' as screens;

final routes = {
  screens.Login.routeName: (_) => const screens.Login(),
  screens.BottomTabs.routeName: (_) => screens.BottomTabs(),
  screens.Search.routeName: (_) => const screens.Search(),
  screens.Champions.routeName: (_) => const screens.Champions(),
  screens.ChampionDetail.routeName: (_) => const screens.ChampionDetail(),
  screens.PlayerDetail.routeName: (_) => const screens.PlayerDetail(),
  screens.ConnectProfile.routeName: (_) => screens.ConnectProfile(),
  screens.Home.routeName: (_) => const screens.Home(),
  screens.Friends.routeName: (_) => screens.Friends(),
  screens.MatchDetail.routeName: (_) => const screens.MatchDetail(),
};

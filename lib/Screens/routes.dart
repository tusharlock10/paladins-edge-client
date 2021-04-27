import './index.dart' as Screens;

final routes = {
  Screens.Login.routeName: (_) => Screens.Login(),
  Screens.BottomTabs.routeName: (_) => Screens.BottomTabs(),
  Screens.Search.routeName: (_) => Screens.Search(),
  Screens.Champions.routeName: (_) => Screens.Champions(),
  Screens.ChampionDetail.routeName: (_) => Screens.ChampionDetail(),
  Screens.PlayerDetail.routeName: (_) => Screens.PlayerDetail(),
  Screens.ConnectProfile.routeName: (_) => Screens.ConnectProfile(),
  Screens.Home.routeName: (_) => Screens.Home(),
};

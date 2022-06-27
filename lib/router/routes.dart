import "package:paladinsedge/screens/index.dart" as screens;

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
  screens.GlobalChat.goRoute,
  screens.Faqs.goRoute,
];

final _loginRoutes = [
  screens.Faqs.loginGoRoute,
];

final rootRoutes = [
  screens.Login.goRouteBuilder(_loginRoutes),
  screens.ConnectProfile.goRoute,
  screens.Main.goRouteBuilder(_mainRoutes),
];

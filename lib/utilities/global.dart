// a singleton class for string global variables

import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;

abstract class Global {
  /// Contains all the essentials data of the app
  static models.Essentials? essentials;

  /// Whether a toast is already being shown to the user
  static bool isToastShown = false;

  /// Whether the user is logged into the app
  static bool isAuthenticated = false;

  /// Whether the user is connected to a player
  /// If user is logged in and player=null,
  /// then open connectPlayer modal
  static bool isPlayerConnected = false;

  /// used to detect if the route is being accessed initially
  static bool isInitialRoute = true;

  /// a list of all paladins asset keys
  static Map<String, Set<String>> paladinsAssets = {
    constants.ChampionAssetType.abilities: <String>{},
    constants.ChampionAssetType.cards: <String>{},
    constants.ChampionAssetType.header: <String>{},
    constants.ChampionAssetType.icons: <String>{},
    constants.ChampionAssetType.splash: <String>{},
    constants.ChampionAssetType.talents: <String>{},
    constants.ChampionAssetType.ranks: <String>{},
  };
}

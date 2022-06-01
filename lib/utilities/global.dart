// a singleton class for string global variables

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
  /// then navigate to connectProfile
  static bool isPlayerConnected = false;

  /// used to detect if the route is being accessed initially
  static bool isInitialRoute = true;
}

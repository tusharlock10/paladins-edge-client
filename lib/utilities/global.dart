// a singleton class for string global variables

import 'package:paladinsedge/models/index.dart' as models;

abstract class Global {
  /// Contains all the essentials data of the app
  static models.Essentials? essentials;

  /// Whether a toast is already being shown to the user
  static bool isToastShown = false;
}

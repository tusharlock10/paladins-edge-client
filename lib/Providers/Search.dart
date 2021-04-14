import 'package:flutter/foundation.dart';

import '../Utilities/index.dart' as Utilities;
import '../Models/index.dart' as Models;
import '../Constants.dart' as Constants;

class Search with ChangeNotifier {
  bool exactMatch = false;
  List<Map<String, dynamic>>? searchData = null;
  Models.Player? playerData = null;

  Future<bool> searchByName(String playerName) async {
    final response = await Utilities.api.get(
      Constants.URLS.searchPlayers,
      queryParameters: {'playerName': playerName},
    );
    final bool exactMatch = response.data['exactMatch'];
    if (exactMatch) {
      this.playerData = Models.Player.fromJson(response.data['playerData']);
    } else {
      this.searchData = response.data['searchData'];
    }
    notifyListeners();
    return exactMatch;
  }
}

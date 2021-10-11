import 'package:flutter/foundation.dart';

import '../Api/index.dart' as Api;
import '../Models/index.dart' as Models;

// Provider to handle players api response

class Players with ChangeNotifier {
  List<Models.Player> friends = [];
  Api.PlayerStatusResponse? playerStatus;

  Future<void> getFriendsList(String playerId) async {
    final response = await Api.PlayersRequests.friendsList(playerId: playerId);
    this.friends = response.friends;
    notifyListeners();
  }

  Future<void> getPlayerStatus(String playerId) async {
    this.playerStatus = null;
    final response = await Api.PlayersRequests.playerStatus(playerId: playerId);
    this.playerStatus = response;
    notifyListeners();
  }
}

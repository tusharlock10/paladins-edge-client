import 'package:flutter/foundation.dart';

import '../Api/index.dart' as Api;
import '../Models/index.dart' as Models;

// Provider to handle players api response

class Players with ChangeNotifier {
  List<Models.Player> friends = [];
  Api.PlayerStatusResponse? playerStatus;

  void moveFriendToTop(String playerId) {
    // the player to move to top of the friends list
    final player =
        this.friends.firstWhere((friend) => friend.playerId == playerId);
    this.friends.removeWhere((friend) => friend.playerId == playerId);
    this.friends.insert(0, player);
    notifyListeners();
  }

  Future<void> getFriendsList(
      String playerId, List<String>? favouriteFriends) async {
    final response = await Api.PlayersRequests.friendsList(playerId: playerId);
    this.friends = response.friends;

    if (favouriteFriends != null) {
      // sort the friends on the basis on name
      this.friends.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      // find favourite players
      final List<Models.Player> favouritePlayers = [];
      this.friends.removeWhere((friend) {
        if (favouriteFriends.contains(friend.playerId)) {
          favouritePlayers.add(friend);
          return true;
        }
        return false;
      });

      this.friends = favouritePlayers + this.friends;
    }

    notifyListeners();
  }

  Future<void> getPlayerStatus(String playerId) async {
    this.playerStatus = null;
    final response = await Api.PlayersRequests.playerStatus(playerId: playerId);
    this.playerStatus = response;
    notifyListeners();
  }
}

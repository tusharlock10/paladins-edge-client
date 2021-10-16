import 'package:flutter/foundation.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

// Provider to handle players api response

class Players with ChangeNotifier {
  List<models.Player> friends = [];
  api.PlayerStatusResponse? playerStatus;

  void moveFriendToTop(String playerId) {
    // the player to move to top of the friends list
    final player = friends.firstWhere((friend) => friend.playerId == playerId);
    friends.removeWhere((friend) => friend.playerId == playerId);
    friends.insert(0, player);
    notifyListeners();
  }

  Future<void> getFriendsList(
      String playerId, List<String>? favouriteFriends) async {
    final response = await api.PlayersRequests.friendsList(playerId: playerId);
    if (response == null) return;
    friends = response.friends;

    if (favouriteFriends != null) {
      // sort the friends on the basis on name
      friends.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      // find favourite players
      final List<models.Player> favouritePlayers = [];
      friends.removeWhere((friend) {
        if (favouriteFriends.contains(friend.playerId)) {
          favouritePlayers.add(friend);
          return true;
        }
        return false;
      });

      friends = favouritePlayers + friends;
    }

    notifyListeners();
  }

  Future<void> getPlayerStatus(String playerId) async {
    playerStatus = null;
    final response = await api.PlayersRequests.playerStatus(playerId: playerId);
    playerStatus = response;
    notifyListeners();
  }
}

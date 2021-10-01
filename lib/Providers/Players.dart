import 'package:flutter/foundation.dart';

import '../Api/index.dart' as Api;
import '../Models/index.dart' as Models;

// Provider to handle players api response

class Players with ChangeNotifier {
  List<Models.Friend> friendsList = [];

  Future<void> getFriendsList(String playerId) async {
    final response = await Api.PlayersRequests.friendsList(playerId: playerId);

    this.friendsList = response.friends;

    notifyListeners();
  }
}

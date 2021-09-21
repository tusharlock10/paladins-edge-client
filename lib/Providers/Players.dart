import 'package:flutter/foundation.dart';

import '../Constants.dart' as Constants;
import '../Models/index.dart' as Models;
import '../Utilities/index.dart' as Utilities;

// Provider to handle players api response

class Players with ChangeNotifier {
  List<Models.Friend> friendsList = [];

  Future<void> getFriendsList(String playerId) async {
    final response = await Utilities.api.get(
      Constants.Urls.friendsList,
      queryParameters: {'playerId': playerId},
    );
    final data = response.data as List<dynamic>;

    this.friendsList =
        data.map((json) => Models.Friend.fromJson(json)).toList();

    notifyListeners();
  }
}

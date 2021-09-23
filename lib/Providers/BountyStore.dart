import 'package:flutter/foundation.dart';

import '../Constants.dart' as Constants;
import '../Models/index.dart' as Models;
import '../Utilities/index.dart' as Utilities;

// Provider to handle bountyStore api response

class BountyStore with ChangeNotifier {
  List<Models.BountyStore> bountyStore = [];

  Future<void> getBountyStoreDetails() async {
    final response =
        await Utilities.api.get<List>(Constants.Urls.bountyStoreDetails);
    if (response.data == null) return;

    this.bountyStore = response.data!
        .map((json) => Models.BountyStore.fromJson(json))
        .toList();

    notifyListeners();
  }
}

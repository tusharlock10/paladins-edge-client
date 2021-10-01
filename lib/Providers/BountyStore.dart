import 'package:flutter/foundation.dart';

import '../Api/index.dart' as Api;
import '../Models/index.dart' as Models;

// Provider to handle bountyStore api response

class BountyStore with ChangeNotifier {
  List<Models.BountyStore> bountyStore = [];

  Future<void> getBountyStoreDetails() async {
    final response = await Api.BountyStoreRequests.bountyStoreDetails();

    this.bountyStore = response.bountyStore;

    notifyListeners();
  }
}

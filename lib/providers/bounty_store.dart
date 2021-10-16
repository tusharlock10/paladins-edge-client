import 'package:flutter/foundation.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

// Provider to handle bountyStore api response

class BountyStore with ChangeNotifier {
  List<models.BountyStore> bountyStore = [];

  Future<void> getBountyStoreDetails() async {
    final response = await api.BountyStoreRequests.bountyStoreDetails();
    if (response == null) return;
    bountyStore = response.bountyStore;
    notifyListeners();
  }
}

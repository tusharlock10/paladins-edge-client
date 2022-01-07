import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _BountyStoreNotifier extends ChangeNotifier {
  List<models.BountyStore> bountyStore = [];

  /// Loads the `bountyStore` data from local db and syncs it with server
  Future<void> loadBountyStore() async {
    final savedBountyStore = utilities.Database.getBountyStore();

    if (savedBountyStore != null) {
      bountyStore = savedBountyStore;

      return notifyListeners();
    }

    final response = await api.BountyStoreRequests.bountyStoreDetails();
    if (response == null) return;
    bountyStore = response.bountyStore;

    // save bounty store locally for future use
    bountyStore.forEach(utilities.Database.saveBountyStore);

    notifyListeners();
  }
}

/// Provider to handle bountyStore
final bountyStore = ChangeNotifierProvider((_) => _BountyStoreNotifier());

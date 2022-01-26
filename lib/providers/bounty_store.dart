import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _BountyStoreNotifier extends ChangeNotifier {
  List<models.BountyStore> bountyStore = [];

  /// Loads the `bountyStore` data from local db and syncs it with server
  Future<List<models.BountyStore>?> loadBountyStore() async {
    final savedBountyStore = utilities.Database.getBountyStore();

    if (savedBountyStore != null) {
      bountyStore = savedBountyStore;

      return bountyStore;
    }

    final response = await api.BountyStoreRequests.bountyStoreDetails();

    if (response == null) return null;

    bountyStore = response.bountyStore;

    // save bounty store locally for future use
    bountyStore.forEach(utilities.Database.saveBountyStore);

    return bountyStore;
  }
}

/// Provider to handle bountyStore
final bountyStore = ChangeNotifierProvider((_) => _BountyStoreNotifier());

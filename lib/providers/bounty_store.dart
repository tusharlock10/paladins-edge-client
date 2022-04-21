import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _BountyStoreNotifier extends ChangeNotifier {
  bool isLoading = true;
  List<models.BountyStore>? bountyStore;

  /// Loads the `bountyStore` data from local db and syncs it with server
  Future<void> loadBountyStore(bool forceUpdate) async {
    final savedBountyStore =
        forceUpdate ? null : utilities.Database.getBountyStore();

    if (savedBountyStore != null) {
      isLoading = false;
      bountyStore = savedBountyStore;

      return utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.BountyStoreRequests.bountyStoreDetails();
    if (response == null) return;

    if (!forceUpdate) isLoading = false;
    bountyStore = response.bountyStore;
    utilities.postFrameCallback(notifyListeners);

    // save bountyStore locally for future use
    // clear bountyStore first if forceUpdate
    if (forceUpdate) await utilities.Database.bountyStoreBox?.clear();
    bountyStore?.forEach(utilities.Database.saveBountyStore);
  }
}

/// Provider to handle bountyStore
final bountyStore = ChangeNotifierProvider((_) => _BountyStoreNotifier());

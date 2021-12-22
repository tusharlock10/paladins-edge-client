import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

class _BountyStoreNotifier extends ChangeNotifier {
  List<models.BountyStore> bountyStore = [];

  /// Loads the `bountyStore` data from local db and syncs it with server
  Future<void> loadBountyStore() async {
    final response = await api.BountyStoreRequests.bountyStoreDetails();
    if (response == null) return;
    bountyStore = response.bountyStore;
    notifyListeners();
  }
}

/// Provider to handle bountyStore
final bountyStore = ChangeNotifierProvider((_) => _BountyStoreNotifier());

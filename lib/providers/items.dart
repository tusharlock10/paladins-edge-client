import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _ItemsNotifier extends ChangeNotifier {
  bool isLoading = true;
  Map<int, models.Item> items = {};

  /// Loads the `item` data from local db and syncs it with server
  Future<void> loadItems() async {
    var itemsList = utilities.Database.getItems();

    if (itemsList == null) {
      final response = await api.ItemRequests.itemDetails();
      if (response == null) return;
      itemsList = response.items;

      // save items locally for future use
      itemsList.forEach(utilities.Database.saveItem);
    }

    for (var item in itemsList) {
      items[item.itemId] = item;
    }
  }
}

/// Provider to handle items
final items = ChangeNotifierProvider((_) => _ItemsNotifier());

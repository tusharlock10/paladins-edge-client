import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _ItemsNotifier extends ChangeNotifier {
  bool isLoading = true;
  List<models.Item>? items;

  /// Loads the `item` data from local db and syncs it with server
  Future<void> loadItems(bool forceUpdate) async {
    final savedItems = forceUpdate ? null : utilities.Database.getItems();

    if (savedItems != null) {
      isLoading = false;
      items = savedItems;

      return utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.CommonRequests.items();
    if (!response.success) return;

    if (!forceUpdate) isLoading = false;
    items = response.data;
    notifyListeners();

    // save items locally for future use
    // clear items first if forceUpdate
    if (forceUpdate) await utilities.Database.itemBox?.clear();
    items?.forEach(utilities.Database.saveItem);
  }
}

/// Provider to handle items
final items = ChangeNotifierProvider((_) => _ItemsNotifier());

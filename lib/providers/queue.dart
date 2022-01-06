import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

class _QueueState extends ChangeNotifier {
  List<models.Queue> queue = [];

  Future<void> getQueueDetails() async {
    final response = await api.QueueRequests.queueDetails();
    if (response == null) return;
    queue = response.queue;

    notifyListeners();
  }
}

/// Provider to handle queue
final queue = ChangeNotifierProvider((_) => _QueueState());

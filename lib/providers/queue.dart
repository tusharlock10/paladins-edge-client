import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

class _QueueState {
  List<models.Queue> queue = [];

  Future<void> getQueueDetails() async {
    final response = await api.QueueRequests.queueDetails();
    if (response == null) return;
    queue = response.queue;
  }
}

/// Provider to handle queue
final queue = Provider((_) => _QueueState());

import 'package:flutter/foundation.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

// Provider to handle queue api response

class Queue with ChangeNotifier {
  List<models.Queue> queues = [];

  Future<void> getQueueDetails() async {
    final response = await api.QueueRequests.queueDetails();
    if (response == null) return;
    queues = response.queues;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

import '../Api/index.dart' as Api;
import '../Models/index.dart' as Models;

// Provider to handle queue api response

class Queue with ChangeNotifier {
  List<Models.Queue> queues = [];

  Future<void> getQueueDetails() async {
    final response = await Api.QueueRequests.queueDetails();
    this.queues = response.queues;

    notifyListeners();
  }
}

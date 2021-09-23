import 'package:flutter/foundation.dart';

import '../Utilities/index.dart' as Utilities;
import '../Models/index.dart' as Models;
import '../Constants.dart' as Constants;

// Provider to handle queue api response

class Queue with ChangeNotifier {
  List<Models.Queue> queues = [];

  Future<void> getQueueDetails() async {
    final response = await Utilities.api.get<List>(Constants.Urls.queueDetails);
    if (response.data == null) return;

    this.queues =
        response.data!.map((json) => Models.Queue.fromJson(json)).toList();

    notifyListeners();
  }
}

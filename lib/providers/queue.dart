import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;

class _QueueState extends ChangeNotifier {
  bool isLoading = true;
  List<models.Queue> queue = [];
  List<models.Queue> timeline = [];
  String selectedQueueId = constants.QueueId.casualSiege;

  // data related to charting
  List<models.Queue> selectedTimeline = [];
  List<FlSpot> chartTimelineData = [];
  double chartMaxX = 0;
  double chartMaxY = 0;
  double chartMinX = double.infinity;
  double chartMinY = double.infinity;

  Future<void> getQueueTimeline() async {
    final response = await api.QueueRequests.queueTimeline();
    if (response == null) return;
    isLoading = false;
    timeline = response.timeline.reversed.toList();

    _getQueue();
    _selectTimelineQueue(selectedQueueId);

    notifyListeners();
  }

  void selectTimelineQueue(String queueId) {
    _selectTimelineQueue(queueId);

    notifyListeners();
  }

  void _selectTimelineQueue(String queueId) {
    // x axis -> index
    // y axis -> activeMatchCount

    double index = -1;

    selectedQueueId = queueId;

    chartMinX = double.infinity;
    chartMinY = double.infinity;
    chartMaxX = 0;
    chartMaxY = 0;

    selectedTimeline =
        timeline.where((queue) => queue.queueId == queueId).toList();
    chartTimelineData = selectedTimeline.map(
      (queue) {
        index++;

        if (queue.activeMatchCount > chartMaxY) {
          chartMaxY = queue.activeMatchCount.toDouble();
        }
        if (queue.activeMatchCount < chartMinY) {
          chartMinY = queue.activeMatchCount.toDouble();
        }

        return FlSpot(index, queue.activeMatchCount.toDouble());
      },
    ).toList();

    chartMaxX = index;
    chartMinX = 0;
  }

  void _getQueue() {
    queue = [];
    for (var queueId in constants.QueueId.list) {
      final index = timeline.lastIndexWhere((_) => _.queueId == queueId);
      if (index != -1) {
        queue.add(timeline[index]);
      }
    }
  }
}

/// Provider to handle queue
final queue = ChangeNotifierProvider((_) => _QueueState());

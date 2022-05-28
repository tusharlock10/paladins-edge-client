import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _QueueState extends ChangeNotifier {
  bool isLoading = true;
  List<models.Queue> queue = [];
  List<models.Queue> timeline = [];
  int selectedQueueId = constants.QueueId.casualSiege;

  // data related to charting
  int smallestUnit =
      28; // i.e. it provides 28 minutes of granularity in the chart
  List<models.Queue> selectedTimeline = [];
  List<FlSpot> chartTimelineData = [];
  double chartMaxX = 0;
  double chartMaxY = 0;
  double chartMinX = double.infinity;
  double chartMinY = double.infinity;

  /// Loads the `timeline` data for the queue from local db and
  /// syncs it with server for showing on Home screen
  Future<void> getQueueTimeline(bool forceUpdate) async {
    final savedQueueTimeline =
        forceUpdate ? null : utilities.Database.getQueueTimeline();

    if (savedQueueTimeline != null) {
      timeline = savedQueueTimeline;
      isLoading = false;
    } else {
      final response = await api.QueueRequests.queueTimeline();

      isLoading = false;
      if (response == null) return utilities.postFrameCallback(notifyListeners);

      timeline = response.timeline;
      timeline.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      if (forceUpdate) await utilities.Database.queueTimelineBox?.clear();
      timeline.forEach(utilities.Database.saveQueue);
    }

    _getQueue();
    _selectTimelineQueue(selectedQueueId);

    utilities.postFrameCallback(notifyListeners);
  }

  void selectTimelineQueue(int queueId) {
    _selectTimelineQueue(queueId);

    notifyListeners();
  }

  void changeTimelineGranularity(int smallestUnit) {
    this.smallestUnit = smallestUnit;

    _selectTimelineQueue(selectedQueueId);

    utilities.postFrameCallback(notifyListeners);
  }

  void _selectTimelineQueue(int queueId) {
    // x axis -> index
    // y axis -> activeMatchCount

    selectedQueueId = queueId;
    selectedTimeline = timeline
        .where((queue) => queue.queueId == selectedQueueId)
        .filterIndexed((_, index) => index % (smallestUnit ~/ 4) == 0)
        .toList();

    chartMinX = 0;
    chartMaxX = selectedTimeline.length - 1;
    chartMinY = double.maxFinite;
    chartMaxY = 0;

    chartTimelineData = selectedTimeline.mapIndexed(
      (index, queue) {
        chartMaxY = max(queue.activeMatchCount.toDouble(), chartMaxY);
        chartMinY = min(queue.activeMatchCount.toDouble(), chartMinY);

        return FlSpot(index.toDouble(), queue.activeMatchCount.toDouble());
      },
    ).toList();
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

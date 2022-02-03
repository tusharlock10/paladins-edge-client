import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

class _QueueState extends ChangeNotifier {
  List<models.Queue> queue = [];
  List<models.Queue> timeline = [];

  // data related to charting
  List<FlSpot> chartTimelineData = [];
  double chartMaxX = 0;
  double chartMaxY = 0;
  double chartMinX = double.infinity;
  double chartMinY = double.infinity;

  Future<void> getQueueDetails() async {
    final response = await api.QueueRequests.queueDetails();
    if (response == null) return;
    queue = response.queue;

    notifyListeners();
  }

  Future<void> getQueueTimeline(String queueId) async {
    final response = await api.QueueRequests.queueTimeline(queueId: queueId);
    if (response == null) return;
    timeline = response.timeline.reversed
        .slice(0, min(response.timeline.length - 1, 360));

    _getChartTimelineData(timeline);

    notifyListeners();
  }

  void _getChartTimelineData(List<models.Queue> timeline) {
    // x axis -> amount of time that has passed
    // y axis -> activeMatchCount

    double index = -1;
    chartMinX = double.infinity;
    chartMinY = double.infinity;
    chartMaxX = 0;
    chartMaxY = 0;

    chartTimelineData = timeline.map((queue) {
      index++;

      if (queue.activeMatchCount > chartMaxY) {
        chartMaxY = queue.activeMatchCount.toDouble();
      }
      if (queue.activeMatchCount < chartMinY) {
        chartMinY = queue.activeMatchCount.toDouble();
      }

      return FlSpot(
        index, // TODO: Change x from index to time of the day
        queue.activeMatchCount.toDouble(),
      );
    }).toList();

    chartMaxX = index;
    chartMinX = 0;
  }
}

/// Provider to handle queue
final queue = ChangeNotifierProvider((_) => _QueueState());

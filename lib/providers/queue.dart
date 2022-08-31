import "dart:math";

import "package:dartx/dartx.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _QueueNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef<_QueueNotifier> ref;

  bool isLoading = true;
  List<models.Queue> queue = [];
  List<models.Queue> timeline = [];
  int selectedQueueId = constants.QueueId.casualSiege;

  /// Charting data
  int smallestUnit =
      28; // i.e. it provides 28 minutes of granularity in the chart
  List<models.Queue> selectedTimeline = [];
  List<FlSpot> chartTimelineData = [];
  double chartMaxX = 0;
  double chartMaxY = 0;
  double chartMinX = double.infinity;
  double chartMinY = double.infinity;

  _QueueNotifier({required this.ref});

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

    _selectTimelineQueue(selectedQueueId);
    _getQueue();

    utilities.postFrameCallback(notifyListeners);
  }

  void selectTimelineQueue(int queueId) {
    _selectTimelineQueue(queueId);
    _getQueue();

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
    final selectedQueueRegion = ref
        .read(
          providers.auth,
        )
        .settings
        .selectedQueueRegion;

    selectedQueueId = queueId;
    final selectedTimelineIterable = timeline
        .where((queue) => queue.queueId == selectedQueueId)
        .filterIndexed((_, index) => index % (smallestUnit ~/ 4) == 0)
        .toList();

    selectedTimeline = selectedQueueRegion != data_classes.Region.all
        ? selectedTimelineIterable.map(
            (queue) {
              final queueRegion = queue.queueRegions.firstOrNullWhere(
                (_) => _.region == selectedQueueRegion,
              );

              if (queueRegion != null) {
                return models.Queue(
                  activeMatchCount: queueRegion.activeMatchCount,
                  name: queue.name,
                  createdAt: queue.createdAt,
                  queueId: queue.queueId,
                  queueRegions: queue.queueRegions,
                );
              }

              return queue;
            },
          ).toList()
        : selectedTimelineIterable.toList();

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
    final selectedQueueRegion = ref
        .read(
          providers.auth,
        )
        .settings
        .selectedQueueRegion;

    queue = [];
    for (var queueId in constants.QueueId.list) {
      var lastQueue = timeline.lastOrNullWhere((_) => _.queueId == queueId);
      if (selectedQueueRegion != data_classes.Region.all) {
        final queueRegion = lastQueue?.queueRegions.firstOrNullWhere(
          (_) => _.region == selectedQueueRegion,
        );
        lastQueue = queueRegion == null || lastQueue == null
            ? lastQueue
            : models.Queue(
                activeMatchCount: queueRegion.activeMatchCount,
                createdAt: lastQueue.createdAt,
                name: lastQueue.name,
                queueId: lastQueue.queueId,
                queueRegions: lastQueue.queueRegions,
              );
      }

      if (lastQueue != null) {
        queue.add(lastQueue);
      }
    }
  }
}

/// Provider to handle queue
final queue = ChangeNotifierProvider((ref) => _QueueNotifier(ref: ref));

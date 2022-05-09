import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class HomeQueueChart extends HookConsumerWidget {
  const HomeQueueChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final queueProvider = ref.read(providers.queue);
    final selectedTimeline =
        ref.watch(providers.queue.select((_) => _.selectedTimeline));
    final chartTimelineData =
        ref.watch(providers.queue.select((_) => _.chartTimelineData));
    final chartMaxX = ref.watch(providers.queue.select((_) => _.chartMaxX));
    final chartMaxY = ref.watch(providers.queue.select((_) => _.chartMaxY));
    final chartMinX = ref.watch(providers.queue.select((_) => _.chartMinX));
    final chartMinY = ref.watch(providers.queue.select((_) => _.chartMinY));

    // Variables
    const gradient = [Color(0xff6dd5ed), Color(0xff2193b0)];
    final smallestUnit = utilities.responsiveCondition(
      context,
      desktop: 12,
      tablet: 16,
      mobile: 24,
    );
    final intervals = utilities.responsiveCondition(
      context,
      desktop: 12,
      tablet: 8,
      mobile: 6,
    );
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final brightness = Theme.of(context).brightness;
    final intervalY = (chartMaxY - chartMinY) / 5;

    // Effects
    useEffect(
      () {
        queueProvider.changeTimelineGranularity(smallestUnit);

        return;
      },
      [smallestUnit],
    );

    // Methods
    final getQueueTimeTitle = useCallback(
      (double _index) {
        final index = _index.toInt();
        final date = selectedTimeline[index].createdAt.toLocal();

        return Jiffy(date).format("h:mm a");
      },
      [selectedTimeline],
    );

    final getLineTooltipItem = useCallback(
      (List<LineBarSpot> touchedSpots) {
        return touchedSpots.map((LineBarSpot touchedSpot) {
          final textStyle = TextStyle(
            color: touchedSpot.bar.colors.first,
            fontSize: 12,
          );

          return LineTooltipItem(
            '${touchedSpot.y.toInt()} at ${getQueueTimeTitle(touchedSpot.x)}',
            textStyle,
          );
        }).toList();
      },
      [selectedTimeline],
    );

    if (selectedTimeline.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 30, left: 10, top: 20),
      child: SizedBox(
        height: 220,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: getLineTooltipItem,
              ),
            ),
            clipData: FlClipData.all(),
            minX: chartMinX,
            maxX: chartMaxX,
            minY: max(chartMinY - intervalY, 0),
            maxY: chartMaxY + intervalY,
            extraLinesData: ExtraLinesData(
              extraLinesOnTop: false,
              horizontalLines: [
                HorizontalLine(
                  y: chartMaxY,
                  strokeWidth: 0.5,
                  color: secondaryColor.withOpacity(0.75),
                  label: HorizontalLineLabel(
                    show: true,
                    style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                    labelResolver: (_) => 'Peak ${_.y.round()}',
                  ),
                ),
              ],
            ),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              topTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (_, __) => const TextStyle(fontSize: 9),
                getTitles: getQueueTimeTitle,
                interval: selectedTimeline.length / intervals,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitles: (value) => defaultGetTitle(
                  utilities
                      .roundToNearestTenth(value.toInt(), offset: 1, ceil: true)
                      .toDouble(),
                ),
                getTextStyles: (_, __) => const TextStyle(fontSize: 10),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                colors: gradient,
                barWidth: 2.5,
                isCurved: true,
                isStrokeCapRound: true,
                preventCurveOverShooting: true,
                shadow: brightness == Brightness.light
                    ? const Shadow(
                        color: Color(0xff5cb7cc),
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      )
                    : const Shadow(
                        color: Color(0xff438999),
                        blurRadius: 7,
                        offset: Offset(0, 5),
                      ),
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  colors: gradient.map((_) => _.withOpacity(0.4)).toList(),
                ),
                spots: chartTimelineData,
              ),
            ],
          ),
          swapAnimationCurve: Curves.decelerate,
          swapAnimationDuration: const Duration(milliseconds: 650),
        ),
      ),
    );
  }
}

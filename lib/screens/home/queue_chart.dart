import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/providers/index.dart' as providers;

class QueueChart extends HookConsumerWidget {
  const QueueChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final timeline = ref.watch(providers.queue.select((_) => _.timeline));
    final chartTimelineData =
        ref.watch(providers.queue.select((_) => _.chartTimelineData));
    final chartMaxX = ref.watch(providers.queue.select((_) => _.chartMaxX));
    final chartMaxY = ref.watch(providers.queue.select((_) => _.chartMaxY));
    final chartMinX = ref.watch(providers.queue.select((_) => _.chartMinX));
    final chartMinY = ref.watch(providers.queue.select((_) => _.chartMinY));

    // Variables
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final themeBrightness = Theme.of(context).brightness;
    final interval = (chartMaxY - chartMinY) / 5;
    const gradient = [Color(0xff6dd5ed), Color(0xff2193b0)];

    // Methods
    final getQueueTimeTitles = useCallback(
      (double _index) {
        const sections = 12;
        final divider = timeline.length ~/ sections;
        final index = _index.toInt();
        if (index % divider != 0) return '';
        final date = timeline[index].createdAt;

        return Jiffy(date).format("h:m a");
      },
      [timeline],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 30, left: 10, top: 20),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            clipData: FlClipData.all(),
            minX: chartMinX,
            maxX: chartMaxX,
            minY: chartMinY - interval,
            maxY: chartMaxY + interval,
            extraLinesData: ExtraLinesData(
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
                reservedSize: 28,
                getTextStyles: (_, __) => const TextStyle(fontSize: 10),
                getTitles: getQueueTimeTitles,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitles: (value) => defaultGetTitle(value),
                getTextStyles: (_, __) => const TextStyle(fontSize: 10),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                shadow: themeBrightness == Brightness.dark
                    ? const Shadow(
                        blurRadius: 10,
                        color: Color(0xff3b7380),
                        offset: Offset(0, 5),
                      )
                    : Shadow(
                        blurRadius: 10,
                        color: gradient.first,
                        offset: const Offset(0, 7),
                      ),
                showingIndicators: [2],
                isStrokeCapRound: true,
                isCurved: true,
                preventCurveOverShooting: true,
                colors: gradient,
                barWidth: 5,
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
          swapAnimationDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }
}

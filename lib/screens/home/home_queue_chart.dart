import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class HomeQueueChart extends HookConsumerWidget {
  const HomeQueueChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final queueProvider = ref.read(providers.queue);
    final isLightTheme = ref.watch(
      providers.auth.select((_) => _.settings.themeMode == ThemeMode.light),
    );
    final selectedTimeline = ref.watch(
      providers.queue.select((_) => _.selectedTimeline),
    );
    final chartTimelineData = ref.watch(
      providers.queue.select((_) => _.chartTimelineData),
    );
    final chartMaxX = ref.watch(providers.queue.select((_) => _.chartMaxX));
    final chartMaxY = ref.watch(providers.queue.select((_) => _.chartMaxY));
    final chartMinX = ref.watch(providers.queue.select((_) => _.chartMinX));
    final chartMinY = ref.watch(providers.queue.select((_) => _.chartMinY));

    // Variables
    const gradient = [Color(0xff4dbdd6), Color(0xff2193b0)];
    final chartHeight = utilities.responsiveCondition(
      context,
      desktop: 260.0,
      tablet: 240.0,
      mobile: 220.0,
    );
    final titleHeightPercent = (chartHeight - 30) / 20;
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

    // Hooks
    final tooltipBgColor = useMemoized(
      () {
        return isLightTheme
            ? theme.themeMaterialColor.shade50.withOpacity(0.75)
            : theme.darkThemeMaterialColor.shade50.withOpacity(0.75);
      },
      [isLightTheme],
    );

    final tooltipItemColor = useMemoized(
      () {
        return isLightTheme ? theme.darkThemeMaterialColor : Colors.white;
      },
      [isLightTheme],
    );

    // Methods
    final getQueueTime = useCallback(
      (double index) {
        final intIndex = index.toInt();
        final date = selectedTimeline[intIndex].createdAt.toLocal();

        return Jiffy(date).format("h:mm a");
      },
      [selectedTimeline],
    );

    final getQueueTimeTitle = useCallback(
      (double index, TitleMeta _) {
        final text = getQueueTime(index);

        return Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            text,
            style: const TextStyle(fontSize: 9),
          ),
        );
      },
      [],
    );

    final getQueuePlayerCount = useCallback(
      (
        double matchCount,
        TitleMeta titleMeta,
      ) {
        bool hide = false;
        final lowerTolerableValue =
            titleMeta.min + (titleMeta.min * titleHeightPercent / 100);
        final upperTolerableValue =
            titleMeta.max - (titleMeta.max * titleHeightPercent / 100);

        if (matchCount == titleMeta.max || matchCount == titleMeta.min) {
          hide = false;
        } else if (matchCount < lowerTolerableValue ||
            matchCount > upperTolerableValue) {
          hide = true;
        }

        final temp = double.tryParse(titleMeta.formattedValue);

        final text = temp == null
            ? titleMeta.formattedValue
            : utilities
                .roundToNearestTenth(
                  temp.toInt(),
                  offset: 1,
                  ceil: true,
                )
                .toString();

        return hide
            ? const SizedBox()
            : Text(
                text,
                style: const TextStyle(fontSize: 10),
              );
      },
      [],
    );

    final getLineTooltipItem = useCallback(
      (List<LineBarSpot> touchedSpots) {
        return touchedSpots.map((LineBarSpot touchedSpot) {
          final textStyle = TextStyle(
            color: tooltipItemColor,
            fontSize: 12,
          );

          return LineTooltipItem(
            '${touchedSpot.y.toInt()} at ${getQueueTime(touchedSpot.x)}',
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
        height: chartHeight,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: getLineTooltipItem,
                tooltipRoundedRadius: 100,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                tooltipMargin: 20,
                tooltipBgColor: tooltipBgColor,
              ),
            ),
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
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getQueueTimeTitle,
                  interval: selectedTimeline.length / intervals,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 28,
                  showTitles: true,
                  getTitlesWidget: getQueuePlayerCount,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradient.map((_) => _.withOpacity(0.4)).toList(),
                  ),
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

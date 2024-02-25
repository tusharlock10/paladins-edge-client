import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/widgets/index.dart" as widgets;

class HomeQueueRegionCard extends HookConsumerWidget {
  const HomeQueueRegionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final appStateProvider = ref.read(providers.appState);
    final queueProvider = ref.read(providers.queue);
    final settings = ref.watch(
      providers.appState.select((_) => _.settings),
    );
    final selectedQueueId = ref.watch(
      providers.queue.select((_) => _.selectedQueueId),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final selectedQueueRegion = settings.selectedQueueRegion;

    // Hooks
    final regionFullName = useMemoized(
      () => data_classes.Region.getFullName(settings.selectedQueueRegion),
      [selectedQueueRegion],
    );

    // Methods
    final setSelectedQueueRegion = useCallback(
      () {
        final nextRegion = data_classes.Region.cycleRegions(
          selectedQueueRegion,
        );
        final newSettings = settings.copyWith(selectedQueueRegion: nextRegion);
        appStateProvider.setSettings(newSettings);
        queueProvider.selectTimelineQueue(selectedQueueId);
      },
      [selectedQueueRegion],
    );

    return widgets.InteractiveCard(
      elevation: 2,
      borderRadius: 10,
      onTap: setSelectedQueueRegion,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Region",
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            regionFullName,
            style: textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

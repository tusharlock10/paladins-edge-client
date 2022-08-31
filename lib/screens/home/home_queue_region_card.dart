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
    final authProvider = ref.read(providers.auth);
    final queueProvider = ref.read(providers.queue);
    final selectedQueueRegion = ref.watch(
      providers.auth.select((_) => _.settings.selectedQueueRegion),
    );
    final selectedQueueId = ref.watch(
      providers.queue.select((_) => _.selectedQueueId),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Hooks
    final regionFullName = useMemoized(
      () => data_classes.Region.getFullName(selectedQueueRegion),
      [selectedQueueRegion],
    );

    // Methods
    final onTap = useCallback(
      () {
        final nextRegion =
            data_classes.Region.cycleRegions(selectedQueueRegion);
        authProvider.setQueueRegions(nextRegion);
        queueProvider.selectTimelineQueue(selectedQueueId);
      },
      [selectedQueueRegion, selectedQueueRegion],
    );

    return widgets.InteractiveCard(
      elevation: 2,
      borderRadius: 10,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Region",
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
          const SizedBox(height: 5),
          Text(
            regionFullName,
            style: textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

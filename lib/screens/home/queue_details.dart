import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class _QueueCard extends StatelessWidget {
  final models.Queue queue;
  final bool isSelected;
  final void Function(String queueId) onTap;

  const _QueueCard({
    required this.queue,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;

    return Card(
      elevation: isSelected ? 2 : 7,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: DecoratedBox(
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 3,
                  color: brightness == Brightness.light
                      ? theme.themeMaterialColor
                      : theme.themeMaterialColor.shade50,
                ),
              )
            : const BoxDecoration(),
        child: InkWell(
          onTap: () => onTap(queue.queueId),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                queue.name.replaceAll(RegExp('_'), ' '),
                textAlign: TextAlign.center,
                style: textTheme.bodyText1,
              ),
              const SizedBox(height: 5),
              Text(
                '${queue.activeMatchCount}',
                style: textTheme.bodyText2?.copyWith(fontSize: 16),
              ),
              isSelected
                  ? Text(
                      'Selected',
                      style: textTheme.bodyText1?.copyWith(
                        fontSize: 12,
                        color: brightness == Brightness.light
                            ? theme.themeMaterialColor
                            : theme.themeMaterialColor.shade50,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class QueueDetails extends HookConsumerWidget {
  const QueueDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final queueProvider = ref.read(providers.queue);
    final queue = ref.watch(providers.queue.select((_) => _.queue));
    final selectedQueueId =
        ref.watch(providers.queue.select((_) => _.selectedQueueId));
    final isLoading = ref.watch(providers.queue.select((_) => _.isLoading));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    const itemHeight = 100;
    final crossAxisCount = utilities.responsiveCondition(
      context,
      desktop: 4,
      tablet: 4,
      mobile: 2,
    );
    final width = utilities.responsiveCondition(
      context,
      desktop: screenWidth * 0.75,
      tablet: screenWidth * 0.75,
      mobile: screenWidth,
    );

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    // Effects
    useEffect(
      () {
        queueProvider.getQueueTimeline();

        return null;
      },
      [],
    );

    // Methods
    final getQueueTimeline = useCallback(
      (String queueId) {
        queueProvider.selectTimelineQueue(queueId);
      },
      [],
    );

    if (isLoading) {
      return const widgets.LoadingIndicator(
        size: 20,
        lineWidth: 2,
        center: true,
        margin: EdgeInsets.all(20),
        label: Text('Loading Queue'),
      );
    }

    return SizedBox(
      width: width,
      child: Column(
        children: [
          Text(
            'Live Queue Numbers',
            style: textTheme.headline3,
          ),
          queue.isEmpty
              ? const Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Sorry we were unable to fetch the queue details',
                      ),
                    ),
                  ),
                )
              : GridView.count(
                  childAspectRatio: childAspectRatio,
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  children: queue
                      .where((_queue) => _queue.queueId != "0")
                      .map(
                        (_queue) => _QueueCard(
                          queue: _queue,
                          isSelected: selectedQueueId == _queue.queueId,
                          onTap: getQueueTimeline,
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/home_queue_card.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class HomeQueueDetails extends HookConsumerWidget {
  const HomeQueueDetails({Key? key}) : super(key: key);

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

    // Methods
    final getQueueTimeline = useCallback(
      (int queueId) {
        queueProvider.selectTimelineQueue(queueId);
      },
      [],
    );

    return isLoading
        ? const widgets.LoadingIndicator(
            lineWidth: 2,
            size: 28,
            margin: EdgeInsets.all(20),
            label: Text('Getting queue'),
          )
        : SizedBox(
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        children: queue
                            .where((_queue) => _queue.queueId != 0)
                            .map(
                              (_queue) => HomeQueueCard(
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

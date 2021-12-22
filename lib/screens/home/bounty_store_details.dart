import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:timer_builder/timer_builder.dart';

class _BountyStoreCard extends StatelessWidget {
  final models.BountyStore bountyStore;

  const _BountyStoreCard({
    required this.bountyStore,
    Key? key,
  }) : super(key: key);

  String getTimeRemaining() {
    final timeDiff = bountyStore.endDate.difference(DateTime.now());
    final endTime = Jiffy({"seconds": timeDiff.inSeconds}).Hms;
    final endDays = timeDiff.inDays;
    String timeRemaining;

    timeRemaining =
        endDays == 0 ? '$endTime remaining' : '$endDays days remaining';

    return timeRemaining;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bountyStore.championName,
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
          Text(
            bountyStore.skinName,
            style: textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
          TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (_) {
              return Text(
                getTimeRemaining(),
                style: textTheme.bodyText2?.copyWith(fontSize: 14),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BountyStoreDetails extends ConsumerWidget {
  const BountyStoreDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const itemHeight = 100;

    final bountyStore =
        ref.watch(providers.bountyStore.select((_) => _.bountyStore));

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    int crossAxisCount = 2;
    double width = size.width;

    if (size.height < size.width) {
      // means in landscape mode, fix the headerHeight
      crossAxisCount = 4;
      width = size.width * 0.75;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    if (bountyStore.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      width: width,
      child: Column(
        children: [
          Text(
            'Bounty Store Updates',
            style: textTheme.headline3,
          ),
          GridView.count(
            childAspectRatio: childAspectRatio,
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            children: bountyStore
                .map(
                  (_bountyStore) => _BountyStoreCard(bountyStore: _bountyStore),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/bounty_store_card.dart';

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
                  (_bountyStore) => BountyStoreCard(bountyStore: _bountyStore),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

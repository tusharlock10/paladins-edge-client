import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/home_bounty_store_card.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class HomeBountyStoreDetails extends HookConsumerWidget {
  const HomeBountyStoreDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final bountyStoreProvider = ref.read(providers.bountyStore);

    // Variables
    const itemHeight = 100;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
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

    return FutureBuilder<List<models.BountyStore>?>(
      future: bountyStoreProvider.loadBountyStore(),
      builder: (context, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const widgets.LoadingIndicator(
            size: 20,
            lineWidth: 2,
            center: true,
            margin: EdgeInsets.all(20),
            label: Text('Loading Bounty Store'),
          );
        }

        if (dataSnapshot.data == null || dataSnapshot.data!.isEmpty) {
          return const Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Sorry we were unable to fetch the bounty store',
                ),
              ),
            ),
          );
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                children: bountyStoreProvider.bountyStore
                    .map(
                      (_bountyStore) =>
                          HomeBountyStoreCard(bountyStore: _bountyStore),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

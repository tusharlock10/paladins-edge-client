import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/home/home_bounty_store_card.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class HomeBountyStoreDetails extends HookConsumerWidget {
  const HomeBountyStoreDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final isLoading = ref.watch(
      providers.bountyStore.select((_) => _.isLoading),
    );
    final bountyStore = ref.watch(
      providers.bountyStore.select((_) => _.bountyStore),
    );

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

    return isLoading
        ? const widgets.LoadingIndicator(
            lineWidth: 2,
            size: 28,
            margin: EdgeInsets.all(20),
            label: Text("Getting bounty store"),
          )
        : bountyStore == null
            ? const Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Sorry we were unable to fetch the bounty store",
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: width,
                child: Column(
                  children: [
                    Text(
                      "Bounty Store Updates",
                      style: textTheme.displaySmall,
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
                      children: bountyStore
                          .map(
                            (bountyStore) =>
                                HomeBountyStoreCard(bountyStore: bountyStore),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
  }
}

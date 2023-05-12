import "package:flutter/material.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:timer_builder/timer_builder.dart";

class HomeBountyStoreCard extends StatelessWidget {
  final models.BountyStore bountyStore;

  const HomeBountyStoreCard({
    required this.bountyStore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bountyStore.championName,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
          Text(
            bountyStore.skinName,
            style: textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
          TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (_) {
              final timeRemaining = utilities.getTimeRemaining(
                fromDate: DateTime.now(),
                toDate: bountyStore.endDate,
              );

              if (timeRemaining == null) {
                return Text(
                  "Expired",
                  style: textTheme.bodyMedium?.copyWith(fontSize: 12),
                );
              }

              return Text(
                "$timeRemaining remaining",
                style: textTheme.bodyMedium?.copyWith(fontSize: 12),
              );
            },
          ),
        ],
      ),
    );
  }
}

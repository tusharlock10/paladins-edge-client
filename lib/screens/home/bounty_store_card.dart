import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;

class BountyStoreCard extends StatelessWidget {
  final models.BountyStore bountyStore;

  const BountyStoreCard({
    required this.bountyStore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final timeDiff = bountyStore.endDate.difference(DateTime.now());
    final endTime = timeDiff.toString();
    final endDays = timeDiff.inDays;
    String timeRemaining;

    if (endDays == 0) {
      timeRemaining = '$endTime remaining';
    } else {
      timeRemaining = '$endDays days remaining';
    }

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
          Text(
            timeRemaining,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class LeaderboardDropdownItem extends StatelessWidget {
  final models.BaseRank baseRank;

  const LeaderboardDropdownItem({
    required this.baseRank,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgets.FastImage(
            imageUrl: utilities.getSmallAsset(
              baseRank.rankIconUrl,
            ),
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 7),
          Text(baseRank.rankName),
        ],
      ),
    );
  }
}

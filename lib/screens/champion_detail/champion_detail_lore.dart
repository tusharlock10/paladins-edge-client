import "package:expand_widget/expand_widget.dart";
import "package:flutter/material.dart";
import "package:paladinsedge/models/index.dart" as models;

class ChampionDetailLore extends StatelessWidget {
  final models.Champion champion;
  const ChampionDetailLore({
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: ExpandText(
          champion.lore,
          maxLines: 8,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: textTheme.bodyMedium?.color?.withOpacity(0.8),
              ),
        ),
      ),
    );
  }
}

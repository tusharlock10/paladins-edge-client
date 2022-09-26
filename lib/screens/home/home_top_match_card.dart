import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class HomeTopMatchCard extends HookConsumerWidget {
  final models.TopMatch topMatch;
  const HomeTopMatchCard({
    required this.topMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTap = useCallback(
      () {
        utilities.Navigation.navigate(
          context,
          screens.MatchDetail.topMatchRouteName,
          params: {
            "matchId": topMatch.matchId,
          },
        );
      },
      [topMatch],
    );

    // Hooks
    final formattedValue = useMemoized(
      () => utilities.humanizeNumber(topMatch.value),
      [topMatch],
    );

    final topMatchName = useMemoized(
      () => constants.TopMatchTypes.getMatchTypeName(topMatch.type),
      [],
    );

    return widgets.InteractiveCard(
      onTap: onTap,
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2),
      borderRadius: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedValue,
                style: textTheme.headline1?.copyWith(fontSize: 32),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topMatch.type == constants.TopMatchTypes.longMatch
                    ? "Minutes"
                    : topMatchName,
                style: textTheme.bodyText1?.copyWith(fontSize: 12, height: 0.8),
              ),
              if (topMatch.type != constants.TopMatchTypes.longMatch)
                RichText(
                  text: TextSpan(
                    text: "by  ",
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    children: [
                      TextSpan(
                        text: topMatch.playerName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              if (topMatch.type == constants.TopMatchTypes.longMatch)
                const Text("Match Time"),
            ],
          ),
          Icon(
            FeatherIcons.chevronRight,
            color: textTheme.bodyText1?.color,
          ),
        ],
      ),
    );
  }
}

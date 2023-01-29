import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;

class SearchLowerItem extends HookWidget {
  final data_classes.LowerSearch lowerSearch;

  const SearchLowerItem({
    required this.lowerSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTap = useCallback(
      () {
        utilities.unFocusKeyboard(context);
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": lowerSearch.playerId.toString(),
          },
        );
      },
      [lowerSearch],
    );

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      lowerSearch.name,
                      scrollPhysics: const ClampingScrollPhysics(),
                      style: textTheme.headline6?.copyWith(fontSize: 16),
                    ),
                    Text(
                      lowerSearch.playerId.toString(),
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                lowerSearch.platform,
                style: textTheme.bodyText1?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

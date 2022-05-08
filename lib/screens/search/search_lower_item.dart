import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class SearchLowerItem extends HookConsumerWidget {
  final api.LowerSearch lowerSearch;

  const SearchLowerItem({
    required this.lowerSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTap = useCallback(
      () {
        utilities.unFocusKeyboard(context);
        playersProvider.setPlayerId(lowerSearch.playerId);
        context.goNamed(screens.PlayerDetail.routeName);
      },
      [],
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
                    Text(
                      lowerSearch.name,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headline6?.copyWith(fontSize: 16),
                    ),
                    Text(
                      lowerSearch.playerId,
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

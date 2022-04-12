import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/connect_profile/connect_profile_player_input.dart';
import 'package:paladinsedge/screens/connect_profile/connect_profile_search_item.dart';

class ConnectProfileSearchList extends ConsumerWidget {
  final bool isLoading;
  final void Function(String) onSearch;
  final void Function(api.LowerSearch) onTap;

  const ConnectProfileSearchList({
    required this.isLoading,
    required this.onSearch,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Variables
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final lowerSearchList =
        ref.watch(providers.players.select((_) => _.lowerSearchList));

    return Column(
      children: [
        const SizedBox(height: 15),
        ConnectProfilePlayerInput(
          isLoading: isLoading,
          onSearch: onSearch,
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: lowerSearchList.length,
            itemBuilder: (context, index) {
              final searchItem = lowerSearchList[index];

              return Column(
                children: [
                  ConnectProfileSearchItem(
                    searchItem: searchItem,
                    onTap: onTap,
                  ),
                  Divider(color: secondaryColor),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/connect_profile/connect_profile_player_input.dart";
import "package:paladinsedge/screens/connect_profile/connect_profile_search_item.dart";

class ConnectProfileSearchList extends ConsumerWidget {
  final bool isLoading;
  final int? isCheckingPlayer;
  final void Function(String) onSearch;
  final void Function(data_classes.LowerSearch) onTap;

  const ConnectProfileSearchList({
    required this.isLoading,
    required this.isCheckingPlayer,
    required this.onSearch,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Variables
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final lowerSearchPlayers = ref.watch(
      providers.players.select((_) => _.lowerSearchPlayers),
    );

    return Column(
      children: [
        const SizedBox(height: 15),
        ConnectProfilePlayerInput(
          isLoading: isLoading,
          onSearch: onSearch,
        ),
        const SizedBox(height: 15),
        lowerSearchPlayers.isEmpty
            ? const SizedBox()
            : Expanded(
                child: ListView.builder(
                  itemCount: lowerSearchPlayers.length,
                  itemBuilder: (context, index) {
                    final searchItem = lowerSearchPlayers[index];

                    return Column(
                      children: [
                        ConnectProfileSearchItem(
                          isCheckingPlayer: isCheckingPlayer,
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

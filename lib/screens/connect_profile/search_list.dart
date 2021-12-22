import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/connect_profile/player_input.dart';

class _SearchItem extends StatelessWidget {
  final api.LowerSearch searchItem;
  final void Function(api.LowerSearch) onTap;

  const _SearchItem({
    required this.searchItem,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final themeData = Theme.of(context);

    return ListTile(
      onTap: () => onTap(searchItem),
      title: Text(
        searchItem.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: themeData.primaryColor,
          fontSize: 18,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Player Id',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          Text(
            searchItem.playerId,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchList extends ConsumerWidget {
  final bool isLoading;
  final void Function(String) onSearch;
  final void Function(api.LowerSearch) onTap;

  const SearchList({
    required this.isLoading,
    required this.onSearch,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowerSearchList =
        ref.watch(providers.players.select((_) => _.lowerSearchList));

    return Column(
      children: [
        PlayerInput(
          isLoading: isLoading,
          onSearch: onSearch,
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: lowerSearchList.length,
            itemBuilder: (context, index) {
              final searchItem = lowerSearchList[index];

              return Column(
                children: [
                  _SearchItem(
                    searchItem: searchItem,
                    onTap: onTap,
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

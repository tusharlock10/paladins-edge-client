import 'package:flutter/material.dart';
import 'package:paladinsedge/api/index.dart' as api;

class ConnectProfileSearchItem extends StatelessWidget {
  final api.LowerSearch searchItem;
  final void Function(api.LowerSearch) onTap;

  const ConnectProfileSearchItem({
    required this.searchItem,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListTile(
      onTap: () => onTap(searchItem),
      title: Text(
        searchItem.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
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

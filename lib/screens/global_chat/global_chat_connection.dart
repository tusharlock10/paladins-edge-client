import 'package:flutter/material.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class GlobalChatConnection extends StatelessWidget {
  final utilities.ChatConnectionState connectionState;
  const GlobalChatConnection({
    required this.connectionState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isUnknown = connectionState == utilities.ChatConnectionState.unknown;
    final isConnected =
        connectionState == utilities.ChatConnectionState.connected;

    if (isUnknown) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets.TextChip(
            color: isConnected ? Colors.green : Colors.red,
            text: isConnected ? 'Online' : 'Offline',
          ),
        ],
      ),
    );
  }
}

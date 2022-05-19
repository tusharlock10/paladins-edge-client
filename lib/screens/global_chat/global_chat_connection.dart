import 'package:flutter/material.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;

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

    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: isConnected ? Colors.green : Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ),
        const SizedBox(width: 3),
        Text(
          isConnected ? 'Online' : 'Offline',
          style: TextStyle(
            fontSize: 12,
            fontFamily: theme.Fonts.secondaryAccent,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

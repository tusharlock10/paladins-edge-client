import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ConnectProfileVerifiedPlayer extends ConsumerWidget {
  const ConnectProfileVerifiedPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.auth.select((_) => _.player));

    // Variables
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    if (player == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        const SizedBox(height: 15),
        const Text('Yay! Profile connected 🎉'),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widgets.ElevatedAvatar(
              size: 24,
              borderRadius: 10,
              imageUrl: player.avatarUrl,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                player.title != null ? Text(player.title!) : const SizedBox(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 150,
          child: TextButton(
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              screens.BottomTabs.routeName,
            ),
            style: TextButton.styleFrom(
              side: BorderSide(width: 1.5, color: secondaryColor),
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
            child: Text(
              'Continue',
              style: TextStyle(color: secondaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

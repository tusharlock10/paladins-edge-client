import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class VerifiedPlayer extends ConsumerWidget {
  const VerifiedPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(providers.auth.select((_) => _.player));
    final themeData = Theme.of(context);
    if (player == null) {
      return Container();
    }
    return Column(
      children: [
        const Text('Congrats, Profile connected'),
        const Text(
            'Now you can enjoy all of the amazing features of paladins edge'),
        Row(
          children: [
            widgets.ElevatedAvatar(
              size: 28,
              borderRadius: 10,
              imageUrl: player.avatarUrl!,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeData.primaryColor,
                    fontSize: 18,
                  ),
                ),
                player.title != null ? Text(player.title!) : const SizedBox(),
              ],
            )
          ],
        ),
        TextButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, screens.BottomTabs.routeName),
            child: const Text('Continue'))
      ],
    );
  }
}

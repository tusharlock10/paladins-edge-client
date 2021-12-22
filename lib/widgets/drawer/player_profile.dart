import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerProfile extends ConsumerWidget {
  const PlayerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(providers.auth.select((_) => _.player));
    final textTheme = Theme.of(context).textTheme;

    if (player != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets.ElevatedAvatar(
            size: 20,
            borderRadius: 0,
            elevation: 5,
            imageUrl: player.avatarUrl!,
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            children: [
              Text(
                player.name,
                style: textTheme.headline1?.copyWith(fontSize: 18),
              ),
              player.title != null
                  ? Text(
                      player.title!,
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

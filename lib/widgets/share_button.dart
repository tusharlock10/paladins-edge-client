import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:share_plus/share_plus.dart';

class ShareButton extends HookWidget {
  final models.Player? player;
  final models.Champion? champion;
  final models.Match? match;
  final models.Loadout? loadout;

  const ShareButton({
    this.player,
    this.champion,
    this.match,
    this.loadout,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // State
    final loading = useState(false);

    // Methods
    final getDynamicLink = useCallback(
      () {
        if (player != null) {
          return utilities.DynamicLinks.generatePlayerDynamicLink(player!);
        }
        if (champion != null) {
          return utilities.DynamicLinks.generateChampionDynamicLink(champion!);
        }
        if (match != null) {
          return utilities.DynamicLinks.generateMatchDynamicLink(match!);
        }
        if (loadout != null) {
          return utilities.DynamicLinks.generateLoadoutDynamicLink(loadout!);
        }
      },
      [match, player, loadout, champion],
    );

    final onShare = useCallback(
      () async {
        loading.value = true;
        final dynamicLink = await getDynamicLink();
        if (dynamicLink == null) {
          loading.value = false;

          return;
        }

        Share.share(dynamicLink.toString());

        loading.value = false;
      },
      [match, player, loadout, champion],
    );

    if (loadout != null && loadout!.loadoutHash == null) {
      return const SizedBox();
    }

    return IconButton(
      onPressed: loading.value ? null : onShare,
      icon: const Icon(
        FeatherIcons.share,
        size: 18,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/screens/champion_detail/abilities.dart';
import 'package:paladinsedge/screens/champion_detail/champion_app_bar.dart';
import 'package:paladinsedge/screens/champion_detail/champion_heading.dart';
import 'package:paladinsedge/screens/champion_detail/loadout_cards.dart';
import 'package:paladinsedge/screens/champion_detail/lore.dart';
import 'package:paladinsedge/screens/champion_detail/player_stats.dart';
import 'package:paladinsedge/screens/champion_detail/talents.dart';
import 'package:paladinsedge/screens/champion_detail/title_label.dart';
import 'package:paladinsedge/screens/index.dart' as screens;

class ChampionDetail extends HookConsumerWidget {
  static const routeName = '/champion';
  const ChampionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final hideLoadoutFab = useState(false);

    // Variables
    final primaryColor = Theme.of(context).primaryColor;
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;

    // Methods
    final onScrollNotification = useCallback(
      (ScrollNotification notification) {
        if (notification is ScrollEndNotification && hideLoadoutFab.value) {
          hideLoadoutFab.value = false;

          return true;
        }
        if ((notification is ScrollUpdateNotification) &&
            (notification.scrollDelta ?? 0).abs() > 1.2 &&
            !hideLoadoutFab.value) {
          hideLoadoutFab.value = true;
        }

        return true;
      },
      [],
    );

    final onLoadoutPress = useCallback(
      () => Navigator.of(context)
          .pushNamed(screens.Loadouts.routeName, arguments: champion),
      [],
    );

    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 90,
        child: AnimatedSlide(
          offset:
              hideLoadoutFab.value ? const Offset(0, 2) : const Offset(0, 0),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: onLoadoutPress,
            elevation: 4,
            hoverElevation: 6,
            focusElevation: 8,
            backgroundColor: primaryColor,
            child: Text(
              'Loadouts',
              style: textTheme.bodyText2?.copyWith(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            isExtended: true,
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const ChampionAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const ChampionHeading(),
                  const TitleLabel(label: 'Lore'),
                  const Lore(),
                  const TitleLabel(label: 'Talents'),
                  const Talents(),
                  const TitleLabel(label: 'Abilities'),
                  const Abilities(),
                  const TitleLabel(label: 'Loadout Cards'),
                  const LoadoutCards(),
                  const TitleLabel(label: 'Your Stats'),
                  const PlayerStats(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

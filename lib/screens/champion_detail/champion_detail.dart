import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champion_detail/champion_detail_abilities.dart';
import 'package:paladinsedge/screens/champion_detail/champion_detail_app_bar.dart';
import 'package:paladinsedge/screens/champion_detail/champion_detail_heading.dart';
import 'package:paladinsedge/screens/champion_detail/champion_detail_loadout_cards.dart';
import 'package:paladinsedge/screens/champion_detail/champion_detail_lore.dart';
import 'package:paladinsedge/screens/champion_detail/champion_detail_player_stats.dart';
import 'package:paladinsedge/screens/champion_detail/champion_detail_talents.dart';
import 'package:paladinsedge/screens/champion_detail/champion_detail_title_label.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionDetail extends HookConsumerWidget {
  static const routeName = '/champion';

  const ChampionDetail({Key? key}) : super(key: key);

  static BeamPage routeBuilder(
    BuildContext _,
    BeamState __,
    Object? ___,
  ) =>
      const BeamPage(
        title: 'Champion • Paladins Edge',
        child: ChampionDetail(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // State
    final hideLoadoutFab = useState(false);

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final champion = context.currentBeamLocation.data as models.Champion;

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

    final _onLoadoutPress = useCallback(
      () {
        context.beamToNamed(
          screens.Loadouts.routeName,
          data: data_classes.LoadoutScreenArguments(
            champion: champion,
          ),
        );
      },
      [],
    );

    final onLoadoutPress = useCallback(
      () {
        if (isGuest) {
          widgets.showLoginModal(data_classes.ShowLoginModalOptions(
            context: context,
            loginCta: constants.LoginCTA.loadoutFab,
            onSuccess: _onLoadoutPress,
          ));
        } else {
          _onLoadoutPress();
        }
      },
      [isGuest],
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
            backgroundColor: theme.themeMaterialColor,
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
          slivers: [
            const ChampionDetailAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const ChampionDetailHeading(),
                  const ChampionDetailTitleLabel(label: 'Lore'),
                  const ChampionDetailLore(),
                  const ChampionDetailTitleLabel(label: 'Talents'),
                  const ChampionDetailTalents(),
                  const ChampionDetailTitleLabel(label: 'Abilities'),
                  const ChampionDetailAbilities(),
                  const ChampionDetailTitleLabel(label: 'Loadout Cards'),
                  const ChampionDetailLoadoutCards(),
                  const ChampionDetailTitleLabel(label: 'Your Stats'),
                  const ChampionDetailPlayerStats(),
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

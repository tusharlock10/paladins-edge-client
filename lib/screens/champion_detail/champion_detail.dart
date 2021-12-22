import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/screens/champion_detail/abilities.dart';
import 'package:paladinsedge/screens/champion_detail/champion_app_bar.dart';
import 'package:paladinsedge/screens/champion_detail/champion_heading.dart';
import 'package:paladinsedge/screens/champion_detail/champion_stats.dart';
import 'package:paladinsedge/screens/champion_detail/lore.dart';
import 'package:paladinsedge/screens/champion_detail/player_stats.dart';
import 'package:paladinsedge/screens/champion_detail/talents.dart';
import 'package:paladinsedge/screens/champion_detail/title_label.dart';

class ChampionDetail extends ConsumerWidget {
  static const routeName = '/champion';
  const ChampionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const ChampionAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const ChampionHeading(),
                const ChampionStats(),
                const TitleLabel(label: 'Lore'),
                const Lore(),
                const TitleLabel(label: 'Talents'),
                const Talents(),
                const TitleLabel(label: 'Abilities'),
                const Abilities(),
                const TitleLabel(label: 'Your Stats'),
                const PlayerStats(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/app_theme.dart' as app_theme;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:provider/provider.dart';

class ChampionDetail extends StatelessWidget {
  static const routeName = '/champion';
  const ChampionDetail({Key? key}) : super(key: key);

  String getLastPlayedTime(DateTime lastPlayed) {
    // if difference in lastPlayed and now is greater than 1 day,
    // show the full date
    // else from the from now duration
    var lastPlayedTime = '';
    final duration = DateTime.now().difference(lastPlayed);
    if (const Duration(days: 1).compareTo(duration) < 0) {
      lastPlayedTime = Jiffy(lastPlayed).fromNow();
    } else {
      lastPlayedTime = Jiffy(lastPlayed).format('do MMM [at] HH:mm');
    }

    return lastPlayedTime;
  }

  Map<String, dynamic> getStatLabelGridProps(
      BuildContext context, BoxConstraints constraints) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 60.0;
    int crossAxisCount;

    if (size.height < size.width) {
      // for landscape mode
      crossAxisCount = 4;
    } else {
      // for portrait mode
      crossAxisCount = 2;
    }
    final itemWidth = constraints.maxWidth / crossAxisCount;
    return {
      'itemHeight': itemHeight,
      'itemWidth': itemWidth,
      'crossAxisCount': crossAxisCount
    };
  }

  Widget buildAppBar(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    bool showSplash = true;

    double headerHeight;
    if (height < width) {
      // means in landscape mode, fix the headerHeight
      headerHeight = 156;
      showSplash = false;
    } else {
      // make the headerHeight half of width
      headerHeight = width / 2;
    }

    return SliverAppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      forceElevated: true,
      elevation: 7,
      floating: true,
      snap: true,
      backgroundColor: app_theme.darkthemeMaterialColor,
      leading: IconButton(
        iconSize: 20,
        hoverColor: Colors.blueGrey.shade100.withOpacity(0.5),
        icon: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white38,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      expandedHeight: headerHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: showSplash
            ? widgets.FastImage(
                imageUrl: champion.splashUrl,
                fit: BoxFit.cover,
              )
            : Align(
                alignment: Alignment.centerRight,
                child: widgets.FastImage(
                  imageUrl: champion.headerUrl,
                  fit: BoxFit.contain,
                ),
              ),
      ),
    );
  }

  Widget buildChampionHeading(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final textTheme = Theme.of(context).textTheme.headline1;
    final isLightTheme = Provider.of<providers.Auth>(context, listen: false)
            .settings
            .themeMode ==
        ThemeMode.light;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Hero(
            tag: '${champion.championId}Icon',
            child: widgets.ElevatedAvatar(
              imageUrl: champion.iconUrl,
              size: 42,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      champion.name.toUpperCase(),
                      style: textTheme?.copyWith(
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      champion.title.toUpperCase(),
                      style: textTheme?.copyWith(
                        color: isLightTheme
                            ? const Color(0xff5c5c5c)
                            : const Color(0xffb4fb26),
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Wrap(
                        children: champion.tags.map(
                          (tag) {
                            return widgets.TextChip(
                              text: tag.name,
                              color: utilities.getMaterialColorFromHex(
                                tag.color,
                              ),
                              spacing: 5,
                            );
                          },
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChampionStats(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    var fallOffName = 'Range';

    if (champion.damageFallOffRange > 0) {
      fallOffName = 'Fall Off';
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Text('Damage : ${champion.weaponDamage.toInt()}'),
          Text('Fire Rate : ${champion.fireRate}/sec'),
          Text('$fallOffName : ${champion.damageFallOffRange.toInt().abs()}'),
        ],
      ),
    );
  }

  Widget renderTitle(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 10),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.5,
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          child: Text(
            label,
            style: theme.textTheme.headline2?.copyWith(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLore(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;

    if (champion.lore == null) {
      return const SizedBox();
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        child: ExpandText(
          champion.lore!,
          maxLines: 8,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontSize: 14,
                color: textTheme.bodyText2?.color?.withOpacity(0.8),
              ),
        ),
      ),
    );
  }

  Widget buildTalents(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    return Column(
      children: champion.talents?.map(
            (talent) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        talent.imageUrl,
                        height: 114,
                        width: 114,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              talent.name.toUpperCase(),
                              style:
                                  textTheme.headline1?.copyWith(fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Wrap(
                                children: [
                                  widgets.TextChip(
                                    hidden: talent.modifier == "None",
                                    spacing: 5,
                                    text: talent.modifier,
                                    color: Colors.teal,
                                  ),
                                  widgets.TextChip(
                                      hidden: talent.cooldown == 0,
                                      spacing: 5,
                                      text:
                                          '${talent.cooldown.toInt().toString()} sec',
                                      color: Colors.blueGrey,
                                      icon: Icons.timelapse),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: ExpandText(
                                talent.description,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontSize: 14,
                                      color: textTheme.bodyText2?.color
                                          ?.withOpacity(0.8),
                                    ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ).toList() ??
          [],
    );
  }

  Widget buildAbilities(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    return Column(
      children: champion.abilities?.map(
            (ability) {
              final damageTypeChips =
                  ability.damageType.split(',').map((damageType) {
                return constants.championDamageType[damageType];
              });

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                elevation: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: widgets.FastImage(
                              imageUrl: ability.imageUrl,
                              borderRadius: BorderRadius.circular(10),
                              height: 72,
                              width: 72,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(
                                      ability.name.toUpperCase(),
                                      style: textTheme.headline1
                                          ?.copyWith(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Wrap(children: [
                                  ...damageTypeChips.map((damageTypeChip) {
                                    return widgets.TextChip(
                                      spacing: 5,
                                      hidden: damageTypeChip == null,
                                      color: damageTypeChip?['color']
                                          as MaterialColor?,
                                      text: damageTypeChip?['name'] as String?,
                                      icon:
                                          damageTypeChip?['icon'] as IconData?,
                                    );
                                  }),
                                  widgets.TextChip(
                                    hidden: ability.cooldown == 0,
                                    spacing: 5,
                                    text:
                                        '${ability.cooldown.toInt().toString()} sec',
                                    color: Colors.blueGrey,
                                    icon: Icons.timelapse,
                                  ),
                                ])
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ExpandText(
                          utilities.convertAbilityDescription(
                            ability.description,
                          ),
                          maxLines: 3,
                          arrowSize: 24,
                          overflow: TextOverflow.fade,
                          arrowColor:
                              textTheme.bodyText2?.color?.withOpacity(0.8),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontSize: 13,
                                    color: textTheme.bodyText2?.color
                                        ?.withOpacity(0.8),
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ).toList() ??
          [],
    );
  }

  Widget buildStatLabel(
    BuildContext context,
    String label,
    String text,
  ) {
    final theme = Theme.of(context);
    return Card(
      color: theme.primaryColor.withOpacity(0.5),
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: theme.textTheme.headline1
                ?.copyWith(fontSize: 18, color: Colors.white),
          ),
          Text(
            text,
            style: theme.textTheme.headline1?.copyWith(
                fontSize: 14, fontWeight: FontWeight.w200, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildPlayerStats(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final playerChampions =
        Provider.of<providers.Champions>(context, listen: false)
            .playerChampions;
    final playerChampion =
        utilities.findPlayerChampion(playerChampions, champion.championId);

    if (playerChampion == null) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'You have not played enough matches on this champion',
          textAlign: TextAlign.center,
        ),
      );
    }

    final playTimeString =
        '${(playerChampion.playTime ~/ 60)}hrs ${playerChampion.playTime % 60}min';

    String kdr = ((playerChampion.totalKills + playerChampion.totalAssists) /
            playerChampion.totalDeaths)
        .toStringAsPrecision(2);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final props = getStatLabelGridProps(context, constraints);

            final double itemHeight = props['itemHeight'] as double;
            final double itemWidth = props['itemWidth'] as double;
            final int crossAxisCount = props['crossAxisCount'] as int;

            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: itemHeight * 8 / crossAxisCount,
                width: constraints.maxWidth,
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: (itemWidth - 5) / (itemHeight - 5),
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    buildStatLabel(
                      context,
                      'Wins',
                      NumberFormat.compact()
                          .format(playerChampion.wins)
                          .toString(),
                    ),
                    buildStatLabel(
                      context,
                      'Looses',
                      NumberFormat.compact()
                          .format(playerChampion.losses)
                          .toString(),
                    ),
                    buildStatLabel(
                      context,
                      'Kills',
                      NumberFormat.compact()
                          .format(playerChampion.totalKills)
                          .toString(),
                    ),
                    buildStatLabel(
                      context,
                      'Deaths',
                      NumberFormat.compact()
                          .format(playerChampion.totalDeaths)
                          .toString(),
                    ),
                    buildStatLabel(context, 'Play Time', playTimeString),
                    buildStatLabel(
                      context,
                      'Last Played',
                      getLastPlayedTime(playerChampion.lastPlayed),
                    ),
                    buildStatLabel(
                      context,
                      'KD Ratio',
                      kdr,
                    ),
                    buildStatLabel(
                      context,
                      'Credits',
                      '${(playerChampion.totalCredits ~/ playerChampion.playTime).toString()} Per Min',
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return SliverList(
      // Use a delegate to build items as they're scrolled on screen.
      delegate: SliverChildListDelegate(
        [
          buildChampionHeading(context),
          buildChampionStats(context),
          renderTitle(context, 'Lore'),
          buildLore(context),
          renderTitle(context, 'Talents'),
          buildTalents(context),
          renderTitle(context, 'Abilities'),
          buildAbilities(context),
          renderTitle(context, 'Your Stats'),
          buildPlayerStats(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          buildAppBar(context),
          buildList(context),
        ],
      ),
    );
  }
}
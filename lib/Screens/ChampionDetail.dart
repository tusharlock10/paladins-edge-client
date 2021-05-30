import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expand_widget/expand_widget.dart';

import '../Widgets/index.dart' as Widgets;
import '../Models/index.dart' as Models;
import '../Providers/index.dart' as Providers;
import '../Utilities/index.dart' as Utilities;
import '../Constants.dart' as Constants;

class ChampionDetail extends StatelessWidget {
  static const routeName = '/champion';

  Widget buildAppBar(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as Models.Champion;
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
      brightness: Brightness.dark,
      forceElevated: true,
      elevation: 7,
      pinned: true,
      backgroundColor: Constants.DarkThemeMaterialColor,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      expandedHeight: headerHeight,
      flexibleSpace: Container(
        alignment: Alignment.bottomRight,
        child: Widgets.FastImage(
          imageUrl: showSplash ? champion.splashUrl : champion.headerUrl,
          height: headerHeight,
          width: headerHeight * 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildChampionHeading(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as Models.Champion;
    final textTheme = Theme.of(context).textTheme.headline1;
    final isLightTheme = Provider.of<Providers.Auth>(context, listen: false)
            .settings
            .themeMode ==
        ThemeMode.light;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Hero(
            tag: '${champion.championId}Icon',
            child: Widgets.ElevatedAvatar(
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
                            ? Color(0xff5c5c5c)
                            : Color(0xffb4fb26),
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Wrap(
                        children: champion.tags.map(
                          (tag) {
                            return Widgets.TextChip(
                              text: tag.name,
                              color: Utilities.getMaterialColorFromHex(
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

  Widget renderTitle(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Container(
          padding: EdgeInsets.only(left: 7, right: 10),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.5,
                color: theme.accentColor,
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

  Widget buildTalents(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as Models.Champion;
    return Column(
      children: [
        this.renderTitle(context, 'Talents'),
        Container(
          child: Wrap(
            children: champion.talents?.map(
                  (talent) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
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
                                    style: textTheme.headline1
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Wrap(
                                      children: [
                                        Widgets.TextChip(
                                          spacing: 5,
                                          text: talent.modifier,
                                          color: Colors.teal,
                                        ),
                                        Widgets.TextChip(
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
                                    padding: EdgeInsets.all(5),
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
          ),
        ),
      ],
    );
  }

  Widget buildAbilities(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as Models.Champion;
    return Column(
      children: [
        this.renderTitle(context, 'Abilities'),
        Container(
          child: Wrap(
            children: champion.abilities?.map(
                  (ability) {
                    final damageTypeChip =
                        Constants.ChampionDamageType[ability.damageType];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Widgets.FastImage(
                                    imageUrl: ability.imageUrl,
                                    borderRadius: BorderRadius.circular(10),
                                    height: 72,
                                    width: 72,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
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
                                        Widgets.TextChip(
                                          hidden: damageTypeChip == null,
                                          color: damageTypeChip?['color'],
                                          text: damageTypeChip?['name'],
                                          icon: damageTypeChip?['icon'],
                                        ),
                                        Widgets.TextChip(
                                            hidden: ability.cooldown == 0,
                                            spacing: 5,
                                            text:
                                                '${ability.cooldown.toInt().toString()} sec',
                                            color: Colors.blueGrey,
                                            icon: Icons.timelapse),
                                      ])
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: ExpandText(
                                Utilities.convertAbilityDescription(
                                  ability.description,
                                ),
                                maxLines: 3,
                                arrowSize: 24,
                                overflow: TextOverflow.fade,
                                arrowColor: textTheme.bodyText2?.color
                                    ?.withOpacity(0.8),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
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
          ),
        ),
      ],
    );
  }

  Widget buildList(BuildContext context) {
    return SliverList(
      // Use a delegate to build items as they're scrolled on screen.
      delegate: SliverChildListDelegate(
        [
          buildChampionHeading(context),
          buildTalents(context),
          buildAbilities(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          this.buildAppBar(context),
          this.buildList(context),
        ],
      ),
    );
  }
}

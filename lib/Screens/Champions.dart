import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Widgets/index.dart' as Widgets;
import '../Providers/index.dart' as Providers;
import '../Models/index.dart' as Models;
import './index.dart' as Screens;
import '../Constants.dart' as Constants;

class Champions extends StatefulWidget {
  static const routeName = '/champions';

  @override
  _ChampionsState createState() => _ChampionsState();
}

class _ChampionsState extends State<Champions> {
  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    final championsProvider =
        Provider.of<Providers.Champions>(context, listen: false);
    if (this._init) {
      this._init = false;
      championsProvider.fetchChampions().then((_) {
        this.setState(() => this._isLoading = false);
      });
    }
    super.didChangeDependencies();
  }

  Widget buildChampionItem(
    BuildContext context,
    Models.Champion champion,
    double height,
    double width,
  ) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => Navigator.of(context)
              .pushNamed(Screens.ChampionDetail.routeName, arguments: champion),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Hero(
                    tag: '${champion.championId}Icon',
                    child: LayoutBuilder(
                      builder: (context, constraints) => Widgets.ElevatedAvatar(
                        imageUrl: champion.iconUrl,
                        size: (constraints.maxHeight - 10) / 2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          champion.name.toUpperCase(),
                          style: theme.textTheme.headline1?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          Widgets.TextChip(
                            spacing: 5,
                            text: champion.role,
                            color: Constants.ThemeMaterialColor,
                          ),
                          Widgets.TextChip(
                            spacing: 5,
                            hidden: !champion.onFreeRotation,
                            text: 'Free',
                            icon: Icons.rotate_right,
                            color: Colors.green,
                          ),
                          Widgets.TextChip(
                            spacing: 5,
                            hidden: !champion.latestChampion,
                            text: 'New',
                            icon: Icons.star,
                            color: Colors.orange,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChampionsList(BuildContext context) {
    final champions = Provider.of<Providers.Champions>(context).champions;
    final size = MediaQuery.of(context).size;
    final itemHeight = 120.0;
    int crossAxisCount;
    double horizontalPadding;
    double width;

    if (size.height < size.width) {
      // for landscape mode
      crossAxisCount = 2;
      width = size.width * 0.75;
      horizontalPadding = (size.width - width) / 2;
    } else {
      // for portrait mode
      crossAxisCount = 1;
      width = size.width;
      horizontalPadding = 15;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: 5,
      physics: BouncingScrollPhysics(),
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      children: champions.map(
        (champion) {
          return this.buildChampionItem(
            context,
            champion,
            itemHeight,
            itemWidth,
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        title: Text('Champions'),
        brightness: Theme.of(context).primaryColorBrightness,
      ),
      Expanded(
          child: this._isLoading
              ? Center(
                  child: SpinKitRing(
                    lineWidth: 4,
                    color: Constants.ThemeMaterialColor,
                  ),
                )
              : buildChampionsList(context))
    ]);
  }
}

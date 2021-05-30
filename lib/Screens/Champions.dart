import 'package:flutter/material.dart';
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

  buildChampion(BuildContext context, Models.Champion champion) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
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
                  child: Expanded(
                    child: Widgets.ElevatedAvatar(
                      imageUrl: champion.iconUrl,
                      size: 28,
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
    );
  }

  Widget buildChampionsList(BuildContext context) {
    final champions = Provider.of<Providers.Champions>(context).champions;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: champions.length,
      itemBuilder: (context, index) {
        final champion = champions[index];
        return this.buildChampion(context, champion);
      },
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

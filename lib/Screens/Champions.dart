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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(Screens.ChampionDetail.routeName, arguments: champion),
        leading: Hero(
          tag: '${champion.championId}Icon',
          child: Widgets.ShadowAvatar(
            imageUrl: champion.iconUrl,
            size: 28,
          ),
        ),
        title: Text('${champion.name}'),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Widgets/index.dart' as Widgets;
import '../Providers/index.dart' as Providers;
import '../Models/index.dart' as Models;
import './index.dart' as Screens;
import '../Constants.dart' as Constants;

class Champions extends StatelessWidget {
  static const routeName = '/champions';

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
            radius: 28,
          ),
        ),
        title: Text('${champion.name}'),
      ),
    );
  }

  Widget buildChampionsList(BuildContext context) {
    final champions = Provider.of<Providers.Champions>(context).champions;

    return ListView.builder(
      itemCount: champions.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SizedBox(height: 20);
        }
        final champion = champions[index - 1];
        return this.buildChampion(context, champion);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Champions'),
      ),
      body: FutureBuilder(
          future: Provider.of<Providers.Champions>(context, listen: false)
              .fetchChampions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: SpinKitRing(
                  lineWidth: 4,
                  color: Constants.ThemeMaterialColor,
                ),
              );
            }
            return buildChampionsList(context);
          }),
    );
  }
}

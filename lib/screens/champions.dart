import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:paladinsedge/app_theme.dart' as app_theme;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:provider/provider.dart';

class Champions extends StatefulWidget {
  static const routeName = '/champions';
  const Champions({Key? key}) : super(key: key);

  @override
  _ChampionsState createState() => _ChampionsState();
}

class _ChampionsState extends State<Champions> {
  bool _init = true;
  bool _isLoading = true;
  String search = '';

  @override
  void didChangeDependencies() {
    final championsProvider =
        Provider.of<providers.Champions>(context, listen: false);
    final authProvider = Provider.of<providers.Auth>(context, listen: false);
    if (_init) {
      _init = false;
      Future.wait([
        championsProvider.fetchChampions(),
        championsProvider.fetchPlayerChampions(authProvider.player!.playerId)
      ]).then((_) {
        setState(() => _isLoading = false);
      });
    }
    super.didChangeDependencies();
  }

  Widget buildLoading() {
    return const Center(
      child: widgets.LoadingIndicator(
        size: 36,
        color: app_theme.themeMaterialColor,
      ),
    );
  }

  Widget buildSearchBar() {
    final textStyle = Theme.of(context).textTheme.headline6?.copyWith(
          color: Colors.white,
          fontSize: 16,
        );
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).primaryColorBrightness),
      title: TextField(
        maxLength: 16,
        enableInteractiveSelection: true,
        style: textStyle,
        onChanged: (search) => setState(() => this.search = search),
        decoration: InputDecoration(
          hintText: 'Search champion',
          counterText: "",
          hintStyle: textStyle,
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() => search = ''),
          ),
        ),
      ),
    );
  }

  Widget buildChampionItem(
    BuildContext context,
    models.Champion champion,
    models.PlayerChampion? playerChampion,
    double height,
    double width,
  ) {
    final theme = Theme.of(context);
    MaterialColor levelColor = Colors.blueGrey;
    if (playerChampion?.level != null && playerChampion!.level > 49) {
      levelColor = Colors.orange;
    }

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => Navigator.of(context)
              .pushNamed(screens.ChampionDetail.routeName, arguments: champion),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Hero(
                    tag: '${champion.championId}Icon',
                    child: LayoutBuilder(
                      builder: (context, constraints) => widgets.ElevatedAvatar(
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
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          champion.name.toUpperCase(),
                          style: theme.textTheme.headline1?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          widgets.TextChip(
                            spacing: 5,
                            text: champion.role,
                            color: app_theme.themeMaterialColor,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: playerChampion?.level == null,
                            text: 'Level ${playerChampion?.level.toString()}',
                            color: levelColor,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: !champion.onFreeRotation,
                            text: 'Free',
                            icon: Icons.rotate_right,
                            color: Colors.green,
                          ),
                          widgets.TextChip(
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
    final championsProvider =
        Provider.of<providers.Champions>(context, listen: false);
    final champions = championsProvider.champions;
    final playerChampions = championsProvider.playerChampions;
    final size = MediaQuery.of(context).size;
    const itemHeight = 120.0;
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

    // modify the champions list according to search
    final newChampions = champions.where((champion) {
      if (search == '') {
        return true;
      } else if (champion.name.toUpperCase().contains(search.toUpperCase())) {
        return true;
      }
      return false;
    });

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: 5,
      physics: const BouncingScrollPhysics(),
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      children: newChampions.map(
        (champion) {
          final playerChampion = utilities.findPlayerChampion(
              playerChampions, champion.championId);
          return buildChampionItem(
            context,
            champion,
            playerChampion,
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
      buildSearchBar(),
      Expanded(
        child: _isLoading ? buildLoading() : buildChampionsList(context),
      )
    ]);
  }
}

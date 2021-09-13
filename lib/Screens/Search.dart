import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import './index.dart' as Screens;
import '../Models/index.dart' as Models;
import '../Providers/index.dart' as Providers;

class Search extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textController = TextEditingController();
  bool isLoading = false;
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (this._init) {
      this._init = false;
      Provider.of<Providers.Search>(context, listen: false).getSearchHistory();
    }
    super.didChangeDependencies();
  }

  void onSearch(
    BuildContext context,
    String playerName, {
    bool addInSeachHistory = true,
  }) async {
    this.setState(() => this.isLoading = true);

    final searchProvider =
        Provider.of<Providers.Search>(context, listen: false);
    final exactMatch = await searchProvider.searchByName(playerName,
        addInSeachHistory: addInSeachHistory);

    this.setState(() => this.isLoading = false);
    if (exactMatch) {
      Navigator.pushNamed(context, Screens.PlayerDetail.routeName);
    }
  }

  Widget buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final searchProvider =
        Provider.of<Providers.Search>(context, listen: false);
    final textStyle = theme.textTheme.headline6?.copyWith(
      color: Colors.white,
      fontSize: 16,
    );
    return SliverAppBar(
      brightness: theme.primaryColorBrightness,
      title: TextField(
        controller: this.textController,
        maxLength: 30,
        enableInteractiveSelection: true,
        style: textStyle,
        cursorColor: theme.primaryColor,
        decoration: InputDecoration(
          hintText: 'Search player',
          counterText: "",
          hintStyle: textStyle,
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.clear),
            onPressed: () {
              searchProvider.clearSearchList();
              this.textController.clear();
            },
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: this.isLoading
              ? SpinKitRing(
                  lineWidth: 2,
                  color: Colors.white,
                  size: 20,
                )
              : Icon(Icons.search),
          onPressed: this.isLoading
              ? null
              : () => this.onSearch(context, this.textController.text),
        ),
      ],
      floating: true,
      elevation: 4,
      forceElevated: true,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
    );
  }

  Widget buildTopSearchItem(Models.Player player) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          Screens.PlayerDetail.routeName,
          arguments: player.playerId,
        );
      },
      title: Text('${player.name}',
          style: Theme.of(context).primaryTextTheme.headline6),
      trailing: player.ranked.rankIconUrl != ""
          ? Image.network(player.ranked.rankIconUrl!)
          : Container(),
    );
  }

  Widget buildLowerSearchItem(
    Map<String, dynamic> searchItem,
  ) {
    return ListTile(
      title: Text('${searchItem['name']}',
          style: Theme.of(context).primaryTextTheme.headline6),
    );
  }

  Widget buildSearchList(BuildContext context) {
    final searchProvider = Provider.of<Providers.Search>(context);
    final topSearchList = searchProvider.topSearchList;
    final lowerSearchList = searchProvider.lowerSearchList;
    final childCount = topSearchList.length + lowerSearchList.length;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < topSearchList.length) {
            return buildTopSearchItem(topSearchList[index]);
          } else {
            return buildLowerSearchItem(
              lowerSearchList[index - topSearchList.length],
            );
          }
        },
        childCount: childCount,
      ),
    );
  }

  Widget buildSearchHistory(BuildContext context) {
    final searchProvider = Provider.of<Providers.Search>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final search = searchProvider.searchHistory[index];
          final String playerName = search['playerName'];
          final DateTime _time = search['time'];
          final time = Jiffy(_time).fromNow();
          return ListTile(
            onTap: () {
              this.textController.text = playerName;
              this.onSearch(context, this.textController.text,
                  addInSeachHistory: false);
            },
            title: Text('$playerName',
                style: Theme.of(context).primaryTextTheme.headline6),
            trailing: Text(
              '$time',
              style: Theme.of(context).primaryTextTheme.caption,
            ),
          );
        },
        childCount: searchProvider.searchHistory.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<Providers.Search>(context);

    return CustomScrollView(
      slivers: [
        this.buildSearchBar(context),
        searchProvider.topSearchList.isNotEmpty
            ? this.buildSearchList(context)
            : this.buildSearchHistory(context),
      ],
    );
  }
}

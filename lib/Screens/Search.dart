import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jiffy/jiffy.dart';

import '../Providers/index.dart' as Providers;
import '../Models/index.dart' as Models;
import './index.dart' as Screens;

class Search extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textController = TextEditingController();
  bool isLoading = false;

  void onSearch(BuildContext context, String playerName) {
    EasyDebounce.debounce('search', Duration(seconds: 1), () async {
      this.setState(() => this.isLoading = true);
      final searchData = Provider.of<Providers.Search>(context, listen: false);
      final exactMatch = await searchData.searchByName(playerName);
      this.setState(() => this.isLoading = false);
      if (exactMatch) {
        Navigator.pushNamed(context, Screens.PlayerDetail.routeName);
      }
    });
  }

  Widget buildSearchBar(Providers.Search searchData) {
    return SliverAppBar(
      title: TextField(
        controller: this.textController,
        maxLength: 30,
        enableInteractiveSelection: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for a player...',
          counterText: "",
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.clear),
            onPressed: () {
              searchData.clearSearchList();
              this.textController.clear();
            },
          ),
        ),
      ),
      actions: [
        this.isLoading
            ? Padding(
                padding: EdgeInsets.only(right: 10),
                child: SpinKitRing(
                  lineWidth: 2,
                  color: Colors.white,
                  size: 24,
                ),
              )
            : IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  this.onSearch(context, this.textController.text);
                },
              ),
      ],
      floating: true,
      elevation: 4,
      forceElevated: true,
    );
  }

  Widget buildTopSearchItem(Models.Player player) {
    return ListTile(
      title: Text('${player.name}'),
      trailing: player.ranked.rankIconUrl != ""
          ? Image.network(player.ranked.rankIconUrl as String)
          : Container(),
    );
  }

  Widget buildLowerSearchItem(
    Map<String, dynamic> searchItem,
  ) {
    return ListTile(
      title: Text('${searchItem['name']}'),
    );
  }

  Widget buildSearchList(Providers.Search searchData) {
    final topSearchList = searchData.topSearchList;
    final lowerSearchList = searchData.lowerSearchList;
    final childCount = topSearchList.length + lowerSearchList.length;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < topSearchList.length) {
            return buildTopSearchItem(topSearchList[index]);
          } else {
            return buildLowerSearchItem(
                lowerSearchList[index - topSearchList.length]);
          }
        },
        childCount: childCount,
      ),
    );
  }

  Widget buildSearchHistory(Providers.Search searchData) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final search = searchData.searchHistory[index];
          final String playerName = search['playerName'];
          final DateTime _time = search['time'];
          final time = Jiffy(_time).fromNow();
          return ListTile(
            title: Text(
              '$playerName',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Text(
              '$time',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.headline1?.color,
              ),
            ),
          );
        },
        childCount: searchData.searchHistory.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchData = Provider.of<Providers.Search>(context);

    return CustomScrollView(
      slivers: [
        this.buildSearchBar(searchData),
        searchData.topSearchList.isNotEmpty
            ? this.buildSearchList(searchData)
            : this.buildSearchHistory(searchData),
      ],
    );
  }
}

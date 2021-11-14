import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  static const routeName = '/search';

  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textController = TextEditingController();
  bool isLoading = false;
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      _init = false;
      Provider.of<providers.Players>(context, listen: false).getSearchHistory();
    }
    super.didChangeDependencies();
  }

  void onSearch(
    BuildContext context,
    String playerName, {
    bool addInSeachHistory = true,
  }) async {
    setState(() => isLoading = true);

    final searchProvider =
        Provider.of<providers.Players>(context, listen: false);
    final exactMatch = await searchProvider.searchByName(playerName,
        addInSeachHistory: addInSeachHistory);

    setState(() => isLoading = false);
    if (exactMatch) {
      Navigator.pushNamed(context, screens.PlayerDetail.routeName);
    }
  }

  Widget buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final searchProvider =
        Provider.of<providers.Players>(context, listen: false);
    final textStyle = theme.textTheme.headline6?.copyWith(
      color: Colors.white,
      fontSize: 16,
    );
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: theme.primaryColorBrightness,
      ),
      title: TextField(
        controller: textController,
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
            icon: const Icon(Icons.clear),
            onPressed: () {
              searchProvider.clearSearchList();
              textController.clear();
            },
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: isLoading
              ? const SpinKitRing(
                  lineWidth: 2,
                  color: Colors.white,
                  size: 20,
                )
              : const Icon(Icons.search),
          onPressed:
              isLoading ? null : () => onSearch(context, textController.text),
        ),
      ],
      floating: true,
      elevation: 4,
      forceElevated: true,
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarTextStyle: const TextStyle(color: Colors.white),
    );
  }

  Widget buildTopSearchItem(models.Player player) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          screens.PlayerDetail.routeName,
          arguments: player.playerId,
        );
      },
      title: Text(player.name,
          style: Theme.of(context).primaryTextTheme.headline6),
      trailing: player.ranked.rankIconUrl != ""
          ? Image.network(player.ranked.rankIconUrl!)
          : Container(),
    );
  }

  Widget buildLowerSearchItem(
    api.LowerSearch searchItem,
  ) {
    return ListTile(
      title: Text(searchItem.name,
          style: Theme.of(context).primaryTextTheme.headline6),
    );
  }

  Widget buildSearchList(BuildContext context) {
    final searchProvider = Provider.of<providers.Players>(context);
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
    final searchProvider = Provider.of<providers.Players>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final search = searchProvider.searchHistory[index];
          final String playerName = search['playerName'] as String;
          final DateTime _time = search['time'] as DateTime;
          final time = Jiffy(_time).fromNow();
          return ListTile(
            onTap: () {
              textController.text = playerName;
              onSearch(context, textController.text, addInSeachHistory: false);
            },
            title: Text(playerName,
                style: Theme.of(context).primaryTextTheme.headline6),
            trailing: Text(
              time,
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
    final searchProvider = Provider.of<providers.Players>(context);

    return CustomScrollView(
      slivers: [
        buildSearchBar(context),
        searchProvider.topSearchList.isNotEmpty
            ? buildSearchList(context)
            : buildSearchHistory(context),
      ],
    );
  }
}

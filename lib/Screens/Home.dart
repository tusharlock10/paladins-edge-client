import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/index.dart' as Providers;
import './index.dart' as Screens;

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textController = TextEditingController();
  bool isLoading = false;

  void onSearch(BuildContext context, String playerName) async {
    this.setState(() => this.isLoading = true);
    final searchData = Provider.of<Providers.Search>(context, listen: false);
    final exactMatch = await searchData.searchByName(playerName);
    this.setState(() => this.isLoading = false);
    if (exactMatch) {
      Navigator.pushNamed(context, Screens.PlayerDetail.routeName);
    } else {
      // TODO : On this screen, show the search results
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        title: Text('Home'),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: TextField(
          controller: this.textController,
          decoration: InputDecoration(hintText: 'Search for a player...'),
        ),
      ),
      Center(
        child: this.isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () =>
                    this.onSearch(context, this.textController.text),
                child: Text(
                  'Search',
                ),
              ),
      )
    ]);
  }
}

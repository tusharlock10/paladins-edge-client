import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'index.dart' as Screens;

class BottomTabs extends StatefulWidget {
  static const routeName = "/";
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  final _pages = [
    {'screen': Screens.Home(), 'title': 'Home', 'icon': Icons.home_outlined},
    {
      'screen': Screens.Champions(),
      'title': 'Champs',
      'icon': Icons.sports_esports_outlined
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      this._selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: Text('Drawer'),
        ),
      ),
      body: this._pages[_selectedPageIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: this._selectedPageIndex,
        showElevation: true,
        onItemSelected: this._selectPage,
        curve: Curves.fastOutSlowIn,
        iconSize: 20,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        items: this
            ._pages
            .map(
              (page) => BottomNavyBarItem(
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.blueGrey,
                icon: Icon(page['icon'] as IconData),
                title: Text(page['title'] as String),
              ),
            )
            .toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import './index.dart' as Screens;
import '../Constants.dart' as Constants;
import '../Widgets/index.dart' as Widgets;

class BottomTabs extends StatefulWidget {
  static const routeName = "/main";
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  final _pages = [
    {
      'screen': Screens.Home(),
      'title': 'Home',
      'icon': Icons.home_outlined,
    },
    {
      'screen': Screens.Search(),
      'title': 'Search',
      'icon': Icons.search_outlined
    },
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
      drawer: Widgets.AppDrawer(),
      body: IndexedStack(
        children: this._pages.map((page) => page['screen'] as Widget).toList(),
        index: this._selectedPageIndex,
      ),
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
                activeColor: Constants.ThemeMaterialColor,
                inactiveColor: Constants.ThemeMaterialColor.shade300,
                icon: Icon(page['icon'] as IconData),
                title: Text(page['title'] as String),
              ),
            )
            .toList(),
      ),
    );
  }
}

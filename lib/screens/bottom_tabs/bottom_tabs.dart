import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class BottomTabs extends StatefulWidget {
  static const routeName = "/main";
  const BottomTabs({Key? key}) : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  final _pages = [
    {
      'screen': const screens.Home(),
      'title': 'Home',
      'icon': Icons.home_outlined,
    },
    {
      'screen': const screens.Search(),
      'title': 'Search',
      'icon': Icons.search_outlined,
    },
    {
      'screen': const screens.Champions(),
      'title': 'Champs',
      'icon': Icons.sports_esports_outlined,
    },
  ];

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarTheme = Theme.of(context).bottomNavigationBarTheme;

    return Scaffold(
      drawer: const widgets.AppDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 3,
      body: IndexedStack(
        children: _pages.map((page) => page['screen'] as Widget).toList(),
        index: _selectedPageIndex,
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: bottomNavigationBarTheme.backgroundColor,
        selectedIndex: _selectedPageIndex,
        onItemSelected: _selectPage,
        curve: Curves.easeIn,
        iconSize: 20,
        animationDuration: const Duration(milliseconds: 350),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        items: _pages
            .map(
              (page) => BottomNavyBarItem(
                activeColor: bottomNavigationBarTheme.selectedItemColor!,
                inactiveColor: bottomNavigationBarTheme.unselectedItemColor!,
                icon: Icon(page['icon'] as IconData),
                title: Text(page['title'] as String),
              ),
            )
            .toList(),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}

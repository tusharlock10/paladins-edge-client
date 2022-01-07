import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class BottomTabs extends HookWidget {
  static const routeName = "/main";

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

  BottomTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarTheme = Theme.of(context).bottomNavigationBarTheme;

    final selectedPageIndex = useState(0);

    return Scaffold(
      drawer: const widgets.AppDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 3,
      body: IndexedStack(
        children: _pages.map((page) => page['screen'] as Widget).toList(),
        index: selectedPageIndex.value,
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: bottomNavigationBarTheme.backgroundColor,
        selectedIndex: selectedPageIndex.value,
        showElevation: true,
        onItemSelected: (index) => selectedPageIndex.value = index,
        curve: Curves.fastOutSlowIn,
        iconSize: 20,
        animationDuration: const Duration(milliseconds: 300),
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
}

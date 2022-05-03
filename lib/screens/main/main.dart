import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/screens/app_drawer/index.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class Main extends HookWidget {
  static const routeName = "/main";

  final _pages = [
    data_classes.BottomTabPage(
      screen: const screens.Home(),
      icon: Icons.home_outlined,
      title: 'Home',
    ),
    data_classes.BottomTabPage(
      screen: const screens.Search(),
      icon: Icons.search_outlined,
      title: 'Search',
    ),
    data_classes.BottomTabPage(
      screen: const screens.Champions(),
      icon: Icons.sports_esports_outlined,
      title: 'Champs',
    ),
  ];

  Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarTheme = Theme.of(context).bottomNavigationBarTheme;

    final selectedPageIndex = useState(0);

    return Scaffold(
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      onDrawerChanged: (isOpened) =>
          isOpened ? utilities.unFocusKeyboard(context) : null,
      body: IndexedStack(
        children: _pages.map((page) => page.screen).toList(),
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
                icon: Icon(page.icon),
                title: Text(page.title),
              ),
            )
            .toList(),
      ),
    );
  }
}

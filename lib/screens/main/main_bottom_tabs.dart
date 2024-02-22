import "package:bottom_navy_bar/bottom_navy_bar.dart";
import "package:flutter/material.dart";
import "package:paladinsedge/screens/main/main_pages.dart";

class MainBottomTabs extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;

  const MainBottomTabs({
    required this.selectedIndex,
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarTheme = Theme.of(context).bottomNavigationBarTheme;

    return BottomNavyBar(
      backgroundColor: bottomNavigationBarTheme.backgroundColor,
      selectedIndex: selectedIndex,
      showElevation: true,
      onItemSelected: onItemSelected,
      curve: Curves.fastOutSlowIn,
      iconSize: 20,
      animationDuration: const Duration(milliseconds: 300),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      items: pages
          .map(
            (page) => BottomNavyBarItem(
              activeColor: bottomNavigationBarTheme.selectedItemColor!,
              inactiveColor: bottomNavigationBarTheme.unselectedItemColor!,
              icon: Icon(page.icon),
              title: Text(page.title),
            ),
          )
          .toList(),
    );
  }
}

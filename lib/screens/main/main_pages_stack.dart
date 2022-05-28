import "package:flutter/material.dart";
import "package:paladinsedge/screens/main/main_pages.dart";

class MainPagesStack extends StatelessWidget {
  final int selectedIndex;
  const MainPagesStack({
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: selectedIndex,
      children: pages.map((page) => page.screen).toList(),
    );
  }
}

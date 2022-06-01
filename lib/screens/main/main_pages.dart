import "package:flutter/material.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/screens/index.dart" as screens;

final pages = [
  data_classes.BottomTabPage(
    screen: const screens.Home(),
    icon: Icons.home_outlined,
    title: "Home",
  ),
  data_classes.BottomTabPage(
    screen: const screens.Search(),
    icon: Icons.search_outlined,
    title: "Search",
  ),
  data_classes.BottomTabPage(
    screen: const screens.Champions(),
    icon: Icons.sports_esports_outlined,
    title: "Champs",
  ),
];

import "package:flutter/material.dart";

class BottomTabPage {
  final Widget screen;
  final String title;
  final IconData icon;

  BottomTabPage({
    required this.screen,
    required this.title,
    required this.icon,
  });
}

enum ApiStatus {
  available,
  serverMaintenance,
  paladinsApiUnavailable,
}

import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch.putIfAbsent(
      (strength * 1000).round(),
      () => Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      ),
    );
  }

  swatch[50] = Color.fromRGBO(
    r + ((255 - r) * 0.75).round(),
    g + ((255 - g) * 0.75).round(),
    b + ((255 - b) * 0.75).round(),
    1,
  );

  return MaterialColor(color.value, swatch);
}

MaterialColor getMaterialColorFromHex(String hexString) {
  // get the material color from a hex string eg. "#ff0000"
  return createMaterialColor(hexString.toColor());
}

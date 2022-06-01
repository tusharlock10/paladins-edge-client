import "package:flutter/material.dart";

const Map<int, Color> _colorValues = {
  50: Color.fromRGBO(217, 245, 255, 1),
  100: Color.fromRGBO(101, 214, 255, 1),
  200: Color.fromRGBO(101, 214, 255, 1),
  300: Color.fromRGBO(101, 214, 255, 1),
  400: Color.fromRGBO(25, 165, 207, 1),
  500: Color.fromRGBO(25, 165, 207, 1),
  600: Color.fromRGBO(25, 165, 207, 1),
  700: Color.fromRGBO(0, 118, 158, 1),
  800: Color.fromRGBO(0, 118, 158, 1),
  900: Color.fromRGBO(0, 118, 158, 1),
};

const Map<int, Color> _darkColorValues = {
  50: Color.fromRGBO(63, 87, 97, 1),
  100: Color.fromRGBO(44, 60, 67, 1),
  200: Color.fromRGBO(44, 60, 67, 1),
  300: Color.fromRGBO(44, 60, 67, 1),
  400: Color.fromRGBO(4, 22, 28, 1),
  500: Color.fromRGBO(4, 22, 28, 1),
  600: Color.fromRGBO(4, 22, 28, 1),
  700: Color.fromRGBO(0, 0, 0, 1),
  800: Color.fromRGBO(0, 0, 0, 1),
  900: Color.fromRGBO(0, 0, 0, 1),
};

const themeMaterialColor = MaterialColor(0xFF19a5cf, _colorValues);
const darkThemeMaterialColor = MaterialColor(0xFF04161c, _darkColorValues);

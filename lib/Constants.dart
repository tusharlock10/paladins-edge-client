import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class URLS {
  // login
  static const login = "/login"; // POST

  // champions
  static const champions = "/champions"; // GET

  // players
  static const searchPlayers = "/searchPlayers"; // GET
}

abstract class STORAGE_KEYS {
  static const token = 'token';
}

const Map<int, Color> _colorValues = {
  50: Color.fromRGBO(33, 147, 176, .1),
  100: Color.fromRGBO(33, 147, 176, .2),
  200: Color.fromRGBO(33, 147, 176, .3),
  300: Color.fromRGBO(33, 147, 176, .4),
  400: Color.fromRGBO(33, 147, 176, .5),
  500: Color.fromRGBO(33, 147, 176, .6),
  600: Color.fromRGBO(33, 147, 176, .7),
  700: Color.fromRGBO(28, 130, 156, .8),
  800: Color.fromRGBO(28, 130, 156, .9),
  900: Color.fromRGBO(22, 125, 148, 1),
};

const themeMaterialColor = MaterialColor(0xFF2193b0, _colorValues);

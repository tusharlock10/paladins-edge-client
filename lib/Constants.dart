import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Urls {
  // login
  static const login = "/auth/login"; // POST

  // champions
  static const allChampions = "/champions/allChampions"; // GET

  // players
  static const searchPlayers = "/players/searchPlayers"; // GET
  static const playerDetail = "/players/playerDetail"; // GET
}

abstract class StorageKeys {
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

const ThemeMaterialColor = MaterialColor(0xFF2193b0, _colorValues);

const IsDebug = kDebugMode;

const BaseUrl = IsDebug
    ? "http://192.168.0.103:8000"
    : "https://paladinsedge.herokuapp.com";

const ApiTimeout = IsDebug ? 4 * 1000 : 10 * 1000;

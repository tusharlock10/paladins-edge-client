import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

abstract class Urls {
  // root
  static const root = "/";

  // auth
  static const login = "/auth/login"; // POST
  static const logout = "/auth/logout"; // POST
  static const fcmToken = "/auth/fcmToken"; // POST
  static const claimPlayer = "/auth/claimPlayer"; // POST
  static const observePlayer = "/auth/observePlayer"; // POST

  // champions
  static const allChampions = "/champions/allChampions"; // GET
  static const playerChampions = "/champions/playerChampions"; // GET

  // players
  static const searchPlayers = "/players/searchPlayers"; // GET
  static const playerDetail = "/players/playerDetail"; // GET
  static const playerStatus = "/players/playerStatus"; // GET
  static const friendsList = "/players/friendsList"; // GET

  // queue
  static const queueDetails = "/queue/queueDetails"; // GET

  // bountyStore
  static const bountyStoreDetails = "/bountyStore/bountyStoreDetails"; // GET
}

abstract class StorageKeys {
  static const token = "token";
}

const IsDebug = kDebugMode;

const BaseUrl =
    IsDebug ? "http://192.168.0.103:8000" : "https://api.paladinsedge.ml";

const ApiTimeout = IsDebug ? 10 * 1000 : 20 * 1000;

const OtpSalt = "EszqnsYd";

abstract class TypeIds {
  // when adding another type id, add it in the
  // bottom with a unique id, do not change the value of the filds above it
  static const Champion = 0;
  static const ChampionAbility = 1;
  static const ChampionTalent = 2;
  static const ChampionCard = 3;
  static const Player = 4;
  static const PlayerRanked = 5;
  static const User = 6;
  static const Settings = 7;
  static const Champion_Tag = 8;
  static const PlayerChampion = 9;
}

const Map<String, Map<String, dynamic>> ChampionDamageType = {
  'Amplification': {"name": "Amplification", "color": Colors.pink},
  'Area Damage': {"name": "Area Damage", "color": Colors.red},
  'Crowd Control': {"name": "Crowd Control", "color": Colors.teal},
  'Direct Damage': {"name": "Direct Damage", "color": Colors.red},
  'Heal': {"name": "Heal", "color": Colors.green},
  'Movement': {"name": "Movement", "color": Colors.amber},
  'Protective': {"name": "Protective", "color": Colors.lightBlue},
  'Reveal': {"name": "Reveal", "color": Colors.amber},
  'Shield': {"name": "Shield", "color": Colors.indigo},
  'Stance Change': {"name": "Stance Change", "color": Colors.pink},
  'Stealth': {"name": "Stealth", "color": Colors.blue},
  'Ultimate': {"name": "Ultimate", "color": Colors.orange},
};

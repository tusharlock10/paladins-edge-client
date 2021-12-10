import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';

const isDebug = kDebugMode;
const isWeb = kIsWeb;
const apiTimeout = isDebug ? 10 * 1000 : 20 * 1000;

abstract class Urls {
  // root
  static const root = "/";

  // auth
  static const login = "/auth/login"; // POST
  static const logout = "/auth/logout"; // POST
  static const claimPlayer = "/auth/claimPlayer"; // POST
  static const observePlayer = "/auth/observePlayer"; // PUT
  static const fcmToken = "/auth/fcmToken"; // POST
  static const essentials = "/auth/essentials"; // GET

  // champions
  static const allChampions = "/champions/allChampions"; // GET
  static const playerChampions = "/champions/playerChampions"; // GET

  // players
  static const searchPlayers = "/players/searchPlayers"; // GET
  static const playerDetail = "/players/playerDetail"; // GET
  static const playerStatus = "/players/playerStatus"; // GET
  static const friendsList = "/players/friendsList"; // GET
  static const favouriteFriend = "/players/favouriteFriend"; // PUT

  // queue
  static const queueDetails = "/queue/queueDetails"; // GET

  // bountyStore
  static const bountyStoreDetails = "/bountyStore/bountyStoreDetails"; // GET

  // match
  static const matchDetails = "/match/matchDetails"; // GET
  static const playerMatches = "/match/playerMatches"; // GET
}

abstract class StorageKeys {
  static const token = "token";
}

// environment variables
abstract class Env {
  static String get appType => _getEnv('APP_TYPE');
  static String get baseUrl => _getEnv('BASE_URL');
  static String get hashSalt => _getEnv('HASH_SALT');

  static String _getEnv(String envName) {
    return dotenv.env[envName] ?? '';
  }

  static Future<List<String>> loadEnv() async {
    await dotenv.load(fileName: "paladins-edge.env");
    final List<String> missingEnvs = [];
    if (appType == '') missingEnvs.add('APP_TYPE');
    if (baseUrl == '') missingEnvs.add('BASE_URL');
    if (hashSalt == '') missingEnvs.add('HASH_SALT');

    return missingEnvs;
  }
}

abstract class TypeIds {
  // when adding another type id, add it at the bottom with a unique
  // incremental id, do not change the value of the fields above it
  static const champion = 0;
  static const championAbility = 1;
  static const championTalent = 2;
  static const championCard = 3;
  static const player = 4;
  static const playerRanked = 5;
  static const user = 6;
  static const settings = 7;
  static const championTag = 8;
  static const playerChampion = 9;
  static const essentials = 10;
}

abstract class NotificationChannels {
  static const friends = 'friends';
}

const Map<String, Map<String, dynamic>> championDamageType = {
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

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paladinsedge/data_classes/champions/index.dart' as data_classes;

const isDebug = kDebugMode;
const isWeb = kIsWeb;
const apiTimeout = isDebug ? 10 * 1000 : 20 * 1000;
const releaseTag = 'alpha';

abstract class Urls {
  // root
  static const root = "/";

  // auth
  static const login = "/auth/login"; // POST
  static const logout = "/auth/logout"; // POST
  static const claimPlayer = "/auth/claimPlayer"; // POST
  static const fcmToken = "/auth/fcmToken"; // POST
  static const essentials = "/auth/essentials"; // GET

  // champions
  static const allChampions = "/champions/allChampions"; // GET
  static const playerChampions = "/champions/playerChampions"; // GET
  static const batchPlayerChampions = '/champions/batchPlayerChampions'; // POST

  // players
  static const searchPlayers = "/players/searchPlayers"; // GET
  static const playerDetail = "/players/playerDetail"; // GET
  static const batchPlayerDetails = "/players/batchPlayerDetails"; // POST
  static const playerStatus = "/players/playerStatus"; // GET
  static const friends = "/players/friends"; // GET
  static const favouriteFriends = "/players/favouriteFriends"; // GET
  static const updateFavouriteFriend = "/players/updateFavouriteFriend"; // PUT
  static const searchHistory = "/players/searchHistory"; // GET

  // queue
  static const queueDetails = "/queue/queueDetails"; // GET
  static const queueTimeline = "/queue/queueTimeline"; // GET

  // bountyStore
  static const bountyStoreDetails = "/bountyStore/bountyStoreDetails"; // GET

  // match
  static const matchDetails = "/match/matchDetails"; // GET
  static const playerMatches = "/match/playerMatches"; // GET

  // loadout
  static const playerLoadouts = "/loadout/playerLoadouts"; // GET
  static const savePlayerLoadout = "/loadout/savePlayerLoadout"; // POST
  static const updatePlayerLoadout = '/loadout/updatePlayerLoadout'; // PUT

  // feedback
  static const submitFeedback = "/feedback/submitFeedback"; // POST
  static const uploadImageUrl = "/feedback/uploadImageUrl"; // GET
}

abstract class StorageKeys {
  static const token = "token";
}

// environment variables
abstract class Env {
  static String get appType => _getEnv('APP_TYPE');
  static String get baseUrl => _getEnv('BASE_URL');
  static String get saltString => _getEnv('SALT_STRING');
  static String get githubLink => _getEnv('GITHUB_LINK');

  static Future<List<String>> loadEnv() async {
    await dotenv.load(fileName: "paladins-edge.env");
    final List<String> missingEnvs = [];
    if (appType == '') missingEnvs.add('APP_TYPE');
    if (baseUrl == '') missingEnvs.add('BASE_URL');
    if (saltString == '') missingEnvs.add('SALT_STRING');
    if (githubLink == '') missingEnvs.add('GITHUB_LINK');

    return missingEnvs;
  }

  static String _getEnv(String envName) {
    return dotenv.env[envName] ?? '';
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
  static const searchHistory = 11;
  static const recordExpiry = 12;
  static const bountyStore = 13;
  static const queue = 14;
}

abstract class NotificationChannels {
  static const friends = 'friends';
}

final Map<String, data_classes.ChampionDamage> championDamageType = {
  'Amplification':
      data_classes.ChampionDamage(name: "Amplification", color: Colors.pink),
  'Area Damage':
      data_classes.ChampionDamage(name: "Area Damage", color: Colors.red),
  'Crowd Control':
      data_classes.ChampionDamage(name: "Crowd Control", color: Colors.teal),
  'Direct Damage':
      data_classes.ChampionDamage(name: "Direct Damage", color: Colors.red),
  'Heal': data_classes.ChampionDamage(name: "Heal", color: Colors.green),
  'Movement':
      data_classes.ChampionDamage(name: "Movement", color: Colors.amber),
  'Protective':
      data_classes.ChampionDamage(name: "Protective", color: Colors.lightBlue),
  'Reveal': data_classes.ChampionDamage(name: "Reveal", color: Colors.amber),
  'Shield': data_classes.ChampionDamage(name: "Shield", color: Colors.indigo),
  'Stance Change':
      data_classes.ChampionDamage(name: "Stance Change", color: Colors.pink),
  'Stealth': data_classes.ChampionDamage(name: "Stealth", color: Colors.blue),
  'Ultimate':
      data_classes.ChampionDamage(name: "Ultimate", color: Colors.orange),
};

abstract class HiveBoxes {
  static const token = "token";
  static const user = "user";
  static const player = "player";
  static const settings = "settings";
  static const essentials = "essentials";
  static const searchHistory = "searchHistory";
  static const champion = "champion";
  static const recordExpiry = "recordExpiry";
  static const bountyStore = "bountyStore";
  static const playerChampion = "playerChampion";
  static const queueTimeline = "queueTimeline";
}

enum RecordExpiryName {
  champion,
  searchHistory,
  bountyStore,
  playerChampion,
  queueTimeline,
}

abstract class RecordExpiryDuration {
  // Time to live duration of these records
  static const championDuration = Duration(days: 1);
  static const searchHistoryDuration = Duration(hours: 1);
  static const bountyStoreDuration = Duration(days: 1);
  static const playerChampionDuration = Duration(days: 1);
  static const queueTimelineDuration = Duration(minutes: 10);
}

abstract class ImageAspectRatios {
  // ratio = width/height
  static const championCard = 4 / 3;
  static const championAbility = 1;
  static const championTalent = 1;
  static const championIcon = 1;
  static const championHeader = 2;
  static const championSplash = 16 / 9;

  static const avatar = 1;

  static const itemIcon = 4 / 3;

  static const rankIcon = 1;

  static const loadoutCard = 1 / 2;

  static const feedbackImage = 4 / 3;
}

abstract class QueueId {
  static const unknown = 0;
  static const casualSiege = 424;
  static const teamDeathmatch = 469;
  static const onslaught = 452;
  static const rankedKeyboard = 486;
  static const rankedController = 428;
  static const shootingRange = 434;
  static const trainingSiege = 425;
  static const trainingTeamDeathmatch = 470;
  static const trainingOnslaught = 453;
  static const testMaps = 445;

  static List<int> get list {
    return [
      unknown,
      casualSiege,
      teamDeathmatch,
      onslaught,
      rankedKeyboard,
      rankedController,
      shootingRange,
      trainingSiege,
      trainingTeamDeathmatch,
      trainingOnslaught,
      testMaps,
    ];
  }
}

abstract class ResponsiveBreakpoints {
  static const double mobile = 480;
  static const double tablet = 800;
  static const double desktop = 1000;
}

abstract class AppType {
  static const development = "development";
  static const staging = "staging";
  static const production = "production";

  static const developmentShort = "dev";
  static const stagingShort = "stage";
  static const productionShort = "prod";

  static String get shortAppType {
    if (Env.appType == production) {
      return productionShort;
    }
    if (Env.appType == staging) {
      return stagingShort;
    }

    return developmentShort;
  }
}

const partyColors = [
  Colors.lightBlue,
  Colors.green,
  Colors.orange,
  Colors.red,
  Colors.pink,
];

abstract class LoginCTA {
  static final friendsDrawer =
      """Friends section allows you to view your in-game friend list,
mark your friends as favorites and
notifies when you favourite friend comes online
"""
          .replaceAll('\n', ' ');

  static final activeMatchDrawer = """Active Match section allows you to
view your live match,
check stats of all the players before loading in
and visit their profile directly
"""
      .replaceAll('\n', ' ');

  static final loadoutFab = """Loadout section allows you to
view your in-game loadouts,
create and save your own
loadouts outside the game 
"""
      .replaceAll('\n', ' ');
}

abstract class RemoteConfigParams {
  static const enableGuestLogin = 'enableGuestLogin';
}

abstract class DynamicLinks {
  static const linkUriHost = "paladinsedge.app";
  static const urlPrefix = "https://paladinsedge.page.link";
  static const packageName = "app.paladinsedge";
  static const appImageKey = "assets/misc/pe_icon_small.png";
}

abstract class DynamicLinkTypes {
  static const player = "player";
  static const match = "match";
  static const loadout = "loadout";
  static const champion = "champion";
}

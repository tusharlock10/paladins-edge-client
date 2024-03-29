import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:paladinsedge/constants/platforms.dart";

const isDebug = kDebugMode;
const apiTimeout = isDebug ? 10 * 1000 : 20 * 1000;
final releaseTag = isWindows ? "alpha" : "stable";

abstract class NotificationChannels {
  static const friends = "friends";
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
  static const chooseAny = 10296;
  static const trainingChooseAny = 10297;

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
      chooseAny,
      trainingChooseAny,
    ];
  }
}

abstract class ResponsiveBreakpoints {
  static const double mobile = 480;
  static const double tablet = 800;
  static const double desktop = 1000;
}

const partyColors = [
  Colors.lightBlue,
  Colors.green,
  Colors.orange,
  Colors.red,
  Colors.pink,
];

const themeNames = {
  ThemeMode.dark: "dark",
  ThemeMode.light: "light",
  ThemeMode.system: "system",
};

const baseUrl = "https://api.paladinsedge.app";
const githubLink = "https://github.com/tusharlock10/paladins-edge-client";
const sponsorLink = "https://github.com/sponsors/tusharlock10";

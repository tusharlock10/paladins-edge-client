import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

const isDebug = kDebugMode;
const isWeb = kIsWeb;
const apiTimeout = isDebug ? 10 * 1000 : 20 * 1000;
const releaseTag = "stable";

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

abstract class RemoteConfigParams {
  static const enableGuestLogin = "enableGuestLogin";
  static const showBackgroundSplash = "showBackgroundSplash";
  static const paladinsApiUnavailable = "paladinsApiUnavailable";
  static const serverMaintenance = "serverMaintenance";
  static const lowestSupportedVersion = "lowestSupportedVersion";
}

abstract class DevicePlatforms {
  static const android = "android";
  static const web = "web";
}

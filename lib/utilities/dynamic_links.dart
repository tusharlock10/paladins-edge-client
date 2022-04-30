import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/asset_urls.dart';

abstract class DynamicLinks {
  static Future<Uri> generateDynamicLink({
    required String type,
    required String value,
    String? title,
    String? description,
    String? imageUrl,
  }) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.https(
        constants.DynamicLinks.linkUriHost,
        '/',
        {'type': type, 'value': value},
      ),
      uriPrefix: constants.DynamicLinks.urlPrefix,
      androidParameters: const AndroidParameters(
        packageName: constants.DynamicLinks.packageName,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        description: description,
        title: title,
        imageUrl: imageUrl != null ? Uri.parse(imageUrl) : null,
      ),
    );

    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
    );

    return dynamicLink.shortUrl;
  }

  static Future<Uri> generateChampionDynamicLink(
    models.Champion champion,
  ) async {
    String adjectiveRote = "";
    if (champion.role == "Damage") adjectiveRote = "potent damage";
    if (champion.role == "Flank") adjectiveRote = "sneaky assassin";
    if (champion.role == "Tank") adjectiveRote = "beefy frontline";
    if (champion.role == "Support") adjectiveRote = "helpful support";

    const type = constants.DynamicLinkTypes.champion;
    final value = champion.championId.toString();
    final title = '${champion.name} - ${champion.title}';
    final description = 'View all about this $adjectiveRote on Paladins Edge';

    return generateDynamicLink(
      type: type,
      value: value,
      title: title,
      description: description,
      imageUrl: getUrlFromKey(constants.DynamicLinks.appImageKey),
    );
  }

  static Future<Uri?> generateLoadoutDynamicLink(
    models.Loadout loadout,
  ) async {
    if (loadout.loadoutHash == null) return null;

    const type = constants.DynamicLinkTypes.champion;
    final value = loadout.loadoutHash!;
    final title = '${loadout.name} - Loadout';
    const description = 'Check this loadout on Paladins Edge';

    return generateDynamicLink(
      type: type,
      value: value,
      title: title,
      description: description,
      imageUrl: getUrlFromKey(constants.DynamicLinks.appImageKey),
    );
  }

  static Future<Uri?> generateMatchDynamicLink(
    models.Match match,
  ) async {
    final queue = match.isRankedMatch ? "Ranked" : match.queue;
    final map = match.map.replaceFirst("LIVE ", "");
    final date = Jiffy(match.matchStartTime).format("do MMM yyyy");

    const type = constants.DynamicLinkTypes.champion;
    final value = match.matchId;
    final title = '$queue - $map';
    final description = 'Check this match from $date on Paladins Edge';

    return generateDynamicLink(
      type: type,
      value: value,
      title: title,
      description: description,
      imageUrl: getUrlFromKey(constants.DynamicLinks.appImageKey),
    );
  }

  static Future<Uri?> generatePlayerDynamicLink(
    models.Player player,
  ) async {
    const type = constants.DynamicLinkTypes.champion;
    final value = player.playerId;
    final title = '${player.name} - ${player.title}';
    const description = 'Check this player profile on Paladins Edge';

    return generateDynamicLink(
      type: type,
      value: value,
      title: title,
      description: description,
      imageUrl: player.avatarUrl,
    );
  }
}

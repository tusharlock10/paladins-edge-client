import "package:paladinsedge/api/loadout/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class LoadoutRequests {
  static Future<responses.PlayerLoadoutsResponse?> playerLoadouts({
    required String playerId,
    required int championId,
    bool forceUpdate = false,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerLoadouts,
        queryParameters: {
          "playerId": playerId,
          "championId": championId,
          "forceUpdate": forceUpdate,
        },
      );
      if (response.data != null) {
        return responses.PlayerLoadoutsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.SavePlayerLoadoutResponse?> savePlayerLoadout({
    required models.Loadout loadout,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.savePlayerLoadout,
        data: {
          "loadout": loadout,
        },
      );
      if (response.data != null) {
        return responses.SavePlayerLoadoutResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.SavePlayerLoadoutResponse?> updatePlayerLoadout({
    required models.Loadout loadout,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.updatePlayerLoadout,
        data: {
          "loadout": loadout,
        },
      );
      if (response.data != null) {
        return responses.SavePlayerLoadoutResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.DeletePlayerLoadoutResponse?> deletePlayerLoadout({
    required String loadoutHash,
    bool? dryRun,
  }) async {
    try {
      final response = await utilities.api.delete<Map<String, dynamic>>(
        constants.Urls.deletePlayerLoadout,
        queryParameters: {
          "loadoutHash": loadoutHash,
          "dryRun": dryRun ?? false,
        },
      );
      if (response.data != null) {
        return responses.DeletePlayerLoadoutResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}

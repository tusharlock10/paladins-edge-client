import "package:paladinsedge/api/auth/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class AuthRequests {
  static Future<responses.CheckPlayerClaimedResponse?> checkPlayerClaimed({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.checkPlayerClaimed,
        queryParameters: {
          "playerId": playerId,
        },
      );
      if (response.data != null) {
        return responses.CheckPlayerClaimedResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.ClaimPlayerResponse?> claimPlayer({
    required String playerId,
    required String verification,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.claimPlayer,
        data: {
          "verification": verification,
          "playerId": playerId,
        },
      );
      if (response.data != null) {
        return responses.ClaimPlayerResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.LoginResponse?> login({
    required String uid,
    required String email,
    required String name,
    required String verification,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.login,
        data: {
          "uid": uid,
          "email": email,
          "name": name,
          "verification": verification,
        },
      );
      if (response.data != null) {
        return responses.LoginResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> logout() async {
    try {
      await utilities.api.post(constants.Urls.logout);

      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<responses.FaqsResponse?> faqs() async {
    try {
      final response =
          await utilities.api.get<Map<String, dynamic>>(constants.Urls.faqs);
      if (response.data != null) {
        return responses.FaqsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.SavedMatchesResponse?> savedMatches() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.savedMatches);
      if (response.data != null) {
        return responses.SavedMatchesResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.UpdateSavedMatchesResponse?> updateSavedMatches({
    required String matchId,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.updateSavedMatches,
        data: {"matchId": matchId},
      );
      if (response.data != null) {
        return responses.UpdateSavedMatchesResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.DeviceDetailResponse?> deviceDetail({
    required models.DeviceDetail deviceDetail,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.deviceDetail,
        data: {"deviceDetail": deviceDetail},
      );
      if (response.data != null) {
        return responses.DeviceDetailResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}

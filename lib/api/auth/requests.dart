import "package:paladinsedge/api/auth/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class AuthRequests {
  static Future<responses.ConnectPlayerResponse?> connectPlayer({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.connectPlayer,
        data: {"playerId": playerId},
      );
      if (response.data != null) {
        return responses.ConnectPlayerResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.EssentialsResponse?> essentials() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.essentials);
      if (response.data != null) {
        return responses.EssentialsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.LoginResponse?> login({
    required String idToken,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.login,
        data: {"idToken": idToken},
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

  static Future<responses.ApiStatusResponse?> apiStatus() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.apiStatus);
      if (response.data != null) {
        return responses.ApiStatusResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.BaseRankResponse?> getBaseRanks() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.baseRanks);
      if (response.data != null) {
        return responses.BaseRankResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.SponsorResponse?> getSponsors() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.sponsors);
      if (response.data != null) {
        return responses.SponsorResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}

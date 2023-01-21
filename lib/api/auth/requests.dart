import "package:paladinsedge/api/auth/responses.dart";
import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class AuthRequests {
  static Future<CheckPlayerClaimedResponse?> checkPlayerClaimed({
    required int playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.checkPlayerClaimed,
        queryParameters: {
          "playerId": playerId,
        },
      );
      if (response.data != null) {
        return CheckPlayerClaimedResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<ClaimPlayerResponse?> claimPlayer({
    required int playerId,
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
        return ClaimPlayerResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<LoginResponse> login({
    required String uid,
    required String email,
    required String name,
    required String verification,
  }) async {
    final payload = {
      "uid": uid,
      "email": email,
      "name": name,
      "verification": verification,
    };
    final input = ApiRequestInput<LoginResponse>(
      url: constants.Urls.login,
      method: HttpMethod.post,
      fromJson: LoginResponse.fromJson,
      defaultValue: LoginResponse(),
      payload: payload,
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<bool> logout() async {
    try {
      await utilities.api.post(constants.Urls.logout);

      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<FaqsResponse?> faqs() async {
    try {
      final response =
          await utilities.api.get<Map<String, dynamic>>(constants.Urls.faqs);
      if (response.data != null) {
        return FaqsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<SavedMatchesResponse?> savedMatches() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.savedMatches);
      if (response.data != null) {
        return SavedMatchesResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<UpdateSavedMatchesResponse?> updateSavedMatches({
    required int matchId,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.updateSavedMatches,
        data: {"matchId": matchId},
      );
      if (response.data != null) {
        return UpdateSavedMatchesResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<DeviceDetailResponse?> deviceDetail({
    required models.DeviceDetail deviceDetail,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.deviceDetail,
        data: {"deviceDetail": deviceDetail},
      );
      if (response.data != null) {
        return DeviceDetailResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}

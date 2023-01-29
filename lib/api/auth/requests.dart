import "package:paladinsedge/api/auth/responses.dart";
import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class AuthRequests {
  static Future<CheckPlayerClaimedResponse> checkPlayerClaimed({
    required int playerId,
  }) async {
    final input = ApiRequestInput<CheckPlayerClaimedResponse>(
      url: constants.Urls.checkPlayerClaimed,
      method: HttpMethod.get,
      fromJson: CheckPlayerClaimedResponse.fromJson,
      defaultValue: CheckPlayerClaimedResponse(),
      pathParams: {
        "playerId": playerId.toString(),
      },
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<ClaimPlayerResponse> claimPlayer({
    required int playerId,
    required String verification,
  }) async {
    final payload = {
      "playerId": playerId,
      "verification": verification,
    };
    final input = ApiRequestInput<ClaimPlayerResponse>(
      url: constants.Urls.claimPlayer,
      method: HttpMethod.post,
      fromJson: ClaimPlayerResponse.fromJson,
      defaultValue: ClaimPlayerResponse(),
      payload: payload,
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
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

  static Future<LogoutResponse> logout() async {
    final input = ApiRequestInput<LogoutResponse>(
      url: constants.Urls.logout,
      method: HttpMethod.post,
      fromJson: LogoutResponse.fromJson,
      defaultValue: LogoutResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<FaqsResponse> faqs() async {
    final input = ApiRequestInput<FaqsResponse>(
      url: constants.Urls.faqs,
      method: HttpMethod.get,
      fromJson: FaqsResponse.fromJson,
      defaultValue: FaqsResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<SavedMatchesResponse> savedMatches() async {
    final input = ApiRequestInput<SavedMatchesResponse>(
      url: constants.Urls.savedMatches,
      method: HttpMethod.get,
      fromJson: SavedMatchesResponse.fromJson,
      defaultValue: SavedMatchesResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<SaveMatchResponse> saveMatch({required int matchId}) async {
    final input = ApiRequestInput<SaveMatchResponse>(
      url: constants.Urls.saveMatch,
      method: HttpMethod.post,
      fromJson: SaveMatchResponse.fromJson,
      defaultValue: SaveMatchResponse(),
      pathParams: {"matchId": matchId.toString()},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
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

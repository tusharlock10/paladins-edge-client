import "package:paladinsedge/api/auth/responses.dart";
import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;

abstract class AuthRequests {
  static Future<CheckPlayerClaimedResponse> checkPlayerClaimed({
    required int playerId,
  }) async {
    final input = ApiRequestInput<CheckPlayerClaimedResponse>(
      url: constants.Urls.checkPlayerClaimed,
      method: HttpMethod.get,
      fromJson: CheckPlayerClaimedResponse.fromJson,
      defaultValue: CheckPlayerClaimedResponse(),
      pathParams: {"playerId": playerId},
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

    if (response.success) {
      final loginData = response.data!;
      final player = loginData.player;

      response.data!.user.playerId = player?.playerId;
    }

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

  static Future<DeviceDetailResponse> registerDevice({
    required models.DeviceDetail deviceDetail,
  }) async {
    final input = ApiRequestInput<DeviceDetailResponse>(
      url: constants.Urls.registerDevice,
      method: HttpMethod.post,
      fromJson: DeviceDetailResponse.fromJson,
      defaultValue: DeviceDetailResponse(),
      payload: deviceDetail,
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }
}

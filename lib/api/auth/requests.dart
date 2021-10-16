import 'package:paladinsedge/api/auth/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class AuthRequests {
  static Future<responses.LoginResponse?> login({
    required String uid,
    String? email,
    String? name,
    String? photoUrl,
  }) async {
    final response = await utilities.api.post<Map<String, dynamic>>(
      constants.Urls.login,
      data: {
        'uid': uid,
        'email': email,
        'name': name,
        'photoUrl': photoUrl,
      },
    );
    if (response.data != null) {
      return responses.LoginResponse.fromJson(response.data!);
    }
  }

  static Future<void> logout() async {
    await utilities.api.post(constants.Urls.logout);
    return;
  }

  static Future<responses.ClaimPlayerResponse?> claimPlayer({
    required String playerId,
    required String otpHash,
  }) async {
    final response = await utilities.api.post<Map<String, dynamic>>(
      constants.Urls.claimPlayer,
      data: {
        'otpHash': otpHash,
        'playerId': playerId,
      },
    );
    if (response.data != null) {
      return responses.ClaimPlayerResponse.fromJson(response.data!);
    }
  }

  static Future<responses.ObservePlayerResponse?> observePlayer(
      {required String playerId}) async {
    final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.observePlayer,
        data: {'playerId': playerId});
    if (response.data != null) {
      return responses.ObservePlayerResponse.fromJson(response.data!);
    }
  }

  static Future<void> fcmToken({required String fcmToken}) async {
    await utilities.api
        .post(constants.Urls.fcmToken, data: {'fcmToken': fcmToken});
    return;
  }
}

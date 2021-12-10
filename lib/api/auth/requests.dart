import 'package:paladinsedge/api/auth/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class AuthRequests {
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
          'uid': uid,
          'email': email,
          'name': name,
          'verification': verification
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
      return true;
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
          'verification': verification,
          'playerId': playerId,
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

  static Future<responses.ObservePlayerResponse?> observePlayer(
      {required String playerId}) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
          constants.Urls.observePlayer,
          data: {'playerId': playerId});
      if (response.data != null) {
        return responses.ObservePlayerResponse.fromJson(response.data!);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> fcmToken({required String fcmToken}) async {
    try {
      await utilities.api
          .post(constants.Urls.fcmToken, data: {'fcmToken': fcmToken});
      return true;
    } catch (_) {
      return false;
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
}

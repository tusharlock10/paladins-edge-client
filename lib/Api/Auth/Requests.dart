import './Responses.dart' as Responses;
import '../../Constants.dart' as Constants;
import '../../Utilities/index.dart' as Utilities;

abstract class AuthRequests {
  static Future<Responses.LoginResponse> login({
    required String uid,
    String? email,
    String? name,
    String? photoUrl,
  }) async {
    final response = await Utilities.api.post(
      Constants.Urls.login,
      data: {
        'uid': uid,
        'email': email,
        'name': name,
        'photoUrl': photoUrl,
      },
    );
    return Responses.LoginResponse.fromJson(response.data);
  }

  static Future<Null> logout() async {
    await Utilities.api.post(Constants.Urls.logout);
    return null;
  }

  static Future<Responses.ClaimPlayerResponse> claimPlayer({
    required String playerId,
    required String otpHash,
  }) async {
    final response = await Utilities.api.post(
      Constants.Urls.claimPlayer,
      data: {
        'otpHash': otpHash,
        'playerId': playerId,
      },
    );

    return Responses.ClaimPlayerResponse.fromJson(response.data);
  }

  static Future<Responses.ObservePlayerResponse> observePlayer(
      {required String playerId}) async {
    final response = await Utilities.api
        .post(Constants.Urls.observePlayer, data: {'playerId': playerId});

    return Responses.ObservePlayerResponse.fromJson(response.data);
  }

  static Future<Null> fcmToken({required String fcmToken}) async {
    await Utilities.api
        .post(Constants.Urls.fcmToken, data: {'fcmToken': fcmToken});
    return null;
  }
}

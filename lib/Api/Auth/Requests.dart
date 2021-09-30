import './Responses.dart' as Responses;
import '../../Constants.dart' as Constants;
import '../../Utilities/index.dart' as Utilities;

class AuthRequests {
  static Future<Responses.LoginResponse> login(
      Map<String, String?> data) async {
    final response = await Utilities.api.post(Constants.Urls.login, data: data);
    return Responses.LoginResponse.fromJson(response.data);
  }
}

import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/common/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;

abstract class CommonRequests {
  static Future<EssentialsResponse> essentials() async {
    final input = ApiRequestInput(
      url: constants.Urls.essentials,
      method: HttpMethod.get,
      fromJson: EssentialsResponse.fromJson,
      defaultValue: EssentialsResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<BountyStoreResponse> bountyStore() async {
    final input = ApiRequestInput<BountyStoreResponse>(
      url: constants.Urls.bountyStore,
      method: HttpMethod.get,
      fromJson: BountyStoreResponse.fromJson,
      defaultValue: BountyStoreResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<ItemsResponse> items() async {
    final input = ApiRequestInput<ItemsResponse>(
      url: constants.Urls.items,
      method: HttpMethod.get,
      fromJson: ItemsResponse.fromJson,
      defaultValue: ItemsResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<FaqsResponse> faq() async {
    final input = ApiRequestInput<FaqsResponse>(
      url: constants.Urls.faq,
      method: HttpMethod.get,
      fromJson: FaqsResponse.fromJson,
      defaultValue: FaqsResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }
}

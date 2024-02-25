import "package:paladinsedge/utilities/index.dart" as utilities;

class PlatformOptimizedImage {
  String optimizedUrl;
  bool isAssetImage;
  final String? blurHash;

  PlatformOptimizedImage({
    required String imageUrl,
    required String assetType,
    required int assetId,
    this.blurHash,
  })  : optimizedUrl =
            utilities.getAssetImageUrl(assetType, assetId) ?? imageUrl,
        isAssetImage = utilities.getAssetImageUrl(assetType, assetId) != null;
}

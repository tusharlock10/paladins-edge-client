import "package:paladinsedge/utilities/index.dart" as utilities;

class PlatformOptimizedImage {
  String optimizedUrl;
  bool isAssetImage;
  String imageUrl;
  String assetType;
  int assetId;
  String? blurHash;

  PlatformOptimizedImage({
    required this.imageUrl,
    required this.assetType,
    required this.assetId,
    this.blurHash,
  })  : optimizedUrl =
            utilities.getAssetImageUrl(assetType, assetId) ?? imageUrl,
        isAssetImage = utilities.getAssetImageUrl(assetType, assetId) != null;
}

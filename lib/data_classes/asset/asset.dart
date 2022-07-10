class PlatformOptimizedImage {
  String imageUrl;
  bool isAssetImage;
  String? blurHash;

  PlatformOptimizedImage({
    required this.imageUrl,
    required this.isAssetImage,
    this.blurHash,
  });
}

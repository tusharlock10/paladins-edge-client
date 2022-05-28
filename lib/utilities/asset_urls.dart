import "package:paladinsedge/utilities/index.dart" as utilities;

/// returns the full s3 image url from its s3 key
String getUrlFromKey(String? key) {
  if (utilities.Global.essentials?.imageBaseUrl == null) return key ?? "";
  if (key == null) return "";
  if (key.contains("https://") || key.contains("http://")) return key;

  return "${utilities.Global.essentials!.imageBaseUrl}$key";
}

/// returns the url with smaller sized version of the network image
String getSmallAsset(String? key) {
  if (key == null) return "";

  return key.replaceFirst("assets", "assets_small");
}

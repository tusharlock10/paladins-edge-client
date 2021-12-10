import 'package:paladinsedge/utilities/index.dart' as utilities;

String getUrlFromKey(String? key) {
  // returns the full s3 asset url from its s3 key

  if (utilities.Global.essentials?.imageBaseUrl == null) {
    return key ?? "";
  }

  if (key == null) {
    return "";
  }

  if (key.contains("https://") || key.contains("http://")) return key;

  return '${utilities.Global.essentials!.imageBaseUrl}$key';
}

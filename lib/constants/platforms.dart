import "dart:io" show Platform;

import "package:flutter/foundation.dart";

const isWeb = kIsWeb;
// need to check for web first as Platform module is not preset on web
final isAndroid = isWeb ? false : Platform.isAndroid;
final isIOS = isWeb ? false : Platform.isIOS;
final isMacOS = isWeb ? false : Platform.isMacOS;
final isWindows = isWeb ? false : Platform.isWindows;

final isMobile = isAndroid || isIOS;
final isCorePlatform = isMobile || isWeb;
final isDesktop = isWindows || isMacOS;

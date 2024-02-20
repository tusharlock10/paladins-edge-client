import "dart:io" show Platform;

import "package:flutter/foundation.dart";

const isWeb = kIsWeb;
final isAndroid = Platform.isAndroid;
final isIOS = Platform.isIOS;
final isMacOS = Platform.isMacOS;
final isWindows = Platform.isWindows;

final isMobile = isAndroid || isIOS;
final isCorePlatform = isMobile || isWeb;
final isDesktop = isWindows || isMacOS;

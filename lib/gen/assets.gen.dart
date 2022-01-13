/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/CustomIcons.ttf
  String get customIcons => 'assets/fonts/CustomIcons.ttf';
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/google-colored.png
  AssetGenImage get googleColored =>
      const AssetGenImage('assets/icons/google-colored.png');

  /// File path: assets/icons/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/icons/icon.png');

  /// File path: assets/icons/paladins.png
  AssetGenImage get paladins =>
      const AssetGenImage('assets/icons/paladins.png');
}

class $AssetsKeysGen {
  const $AssetsKeysGen();

  /// File path: assets/keys/publicKey.pem
  String get publicKey => 'assets/keys/publicKey.pem';
}

class $AssetsSplashGen {
  const $AssetsSplashGen();

  /// File path: assets/splash/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/splash/splash.png');

  /// File path: assets/splash/splash_icon.png
  AssetGenImage get splashIcon =>
      const AssetGenImage('assets/splash/splash_icon.png');
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsKeysGen keys = $AssetsKeysGen();
  static const $AssetsSplashGen splash = $AssetsSplashGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

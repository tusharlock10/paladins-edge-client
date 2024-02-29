/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/CustomIcons.ttf
  String get customIcons => 'assets/fonts/CustomIcons.ttf';

  /// List of all assets
  List<String> get values => [customIcons];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/gold.png
  AssetGenImage get gold => const AssetGenImage('assets/icons/gold.png');

  /// File path: assets/icons/google-colored.png
  AssetGenImage get googleColored =>
      const AssetGenImage('assets/icons/google-colored.png');

  /// File path: assets/icons/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/icons/icon.png');

  /// File path: assets/icons/paladins.png
  AssetGenImage get paladins =>
      const AssetGenImage('assets/icons/paladins.png');

  /// List of all assets
  List<AssetGenImage> get values => [gold, googleColored, icon, paladins];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/not-found.png
  AssetGenImage get notFound =>
      const AssetGenImage('assets/images/not-found.png');

  /// List of all assets
  List<AssetGenImage> get values => [notFound];
}

class $AssetsSplashGen {
  const $AssetsSplashGen();

  /// File path: assets/splash/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/splash/splash.png');

  /// File path: assets/splash/splash_icon.png
  AssetGenImage get splashIcon =>
      const AssetGenImage('assets/splash/splash_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [splash, splashIcon];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSplashGen splash = $AssetsSplashGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ChampionDetailAppBar extends HookWidget {
  final models.Champion champion;
  const ChampionDetailAppBar({
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool showSplash = true;
    double headerHeight;
    if (height < width) {
      // means in landscape mode, fix the headerHeight
      headerHeight = 156;
      showSplash = false;
    } else {
      // make the headerHeight half of width
      headerHeight = width / 2;
    }

    // Hooks
    final splashBackground = useMemoized(
      () {
        var splashBackground = data_classes.PlatformOptimizedImage(
          imageUrl: champion.splashUrl,
          isAssetImage: false,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.splash,
            champion.championId,
          );
          if (assetUrl != null) {
            splashBackground.imageUrl = assetUrl;
            splashBackground.isAssetImage = true;
          }
        }

        return splashBackground;
      },
      [champion],
    );

    return SliverAppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      forceElevated: true,
      floating: true,
      snap: true,
      pinned: constants.isWeb,
      backgroundColor: theme.darkThemeMaterialColor,
      leading: constants.isWeb
          ? null
          : IconButton(
              iconSize: 20,
              hoverColor: Colors.blueGrey.shade100.withOpacity(0.5),
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              onPressed: () => utilities.Navigation.pop(context),
            ),
      expandedHeight: headerHeight,
      collapsedHeight: constants.isWeb ? headerHeight : null,
      flexibleSpace: FlexibleSpaceBar(
        background: showSplash
            ? widgets.FastImage(
                imageUrl: splashBackground.imageUrl,
                imageBlurHash: champion.splashBlurHash,
                fit: BoxFit.cover,
                isAssetImage: splashBackground.isAssetImage,
              )
            : Align(
                alignment: Alignment.centerRight,
                child: widgets.FastImage(
                  imageUrl: champion.headerUrl,
                  height: headerHeight,
                  width: headerHeight * 2,
                ),
              ),
      ),
    );
  }
}

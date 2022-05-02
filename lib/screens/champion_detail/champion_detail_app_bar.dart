import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionDetailAppBar extends StatelessWidget {
  const ChampionDetailAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
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
              onPressed: () => Navigator.pop(context),
            ),
      expandedHeight: headerHeight,
      collapsedHeight: constants.isWeb ? headerHeight : null,
      flexibleSpace: FlexibleSpaceBar(
        background: showSplash
            ? widgets.FastImage(
                imageUrl: champion.splashUrl,
                imageBlurHash: champion.splashBlurHash,
                fit: BoxFit.cover,
              )
            : Align(
                alignment: Alignment.centerRight,
                child: widgets.FastImage(
                  imageUrl: champion.headerUrl,
                  imageBlurHash: champion.headerBlurHash,
                  height: headerHeight,
                  width: headerHeight * 2,
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: theme.darkThemeMaterialColor,
      leading: IconButton(
        iconSize: 20,
        hoverColor: Colors.blueGrey.shade100.withOpacity(0.5),
        icon: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white38,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: const Icon(
            FontAwesomeIcons.xmark,
            color: Colors.white,
            size: 22,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      expandedHeight: headerHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: showSplash
            ? widgets.FastImage(
                imageUrl: champion.splashUrl,
                fit: BoxFit.cover,
              )
            : Align(
                alignment: Alignment.centerRight,
                child: widgets.FastImage(
                  imageUrl: champion.headerUrl,
                  fit: BoxFit.contain,
                ),
              ),
      ),
    );
  }
}

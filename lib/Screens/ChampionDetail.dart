import 'package:flutter/material.dart';

import '../Widgets/index.dart' as Widgets;
import '../Models/index.dart' as Models;

class ChampionDetail extends StatelessWidget {
  static const routeName = '/champion';

  Widget buildAppBar(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as Models.Champion;
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
      forceElevated: true,
      elevation: 7,
      pinned: true,
      snap: true,
      floating: true,
      backgroundColor: Color(0xFF0e242f),
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: Container(
        alignment: Alignment.bottomRight,
        child: Widgets.FastImage(
          imageUrl: showSplash ? champion.splashUrl : champion.headerUrl,
          height: headerHeight,
          width: headerHeight * 2,
          fit: BoxFit.cover,
        ),
      ),
      expandedHeight: headerHeight,
    );
  }

  Widget buildList(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as Models.Champion;
    return SliverList(
      // Use a delegate to build items as they're scrolled on screen.
      delegate: SliverChildListDelegate(
        [
          Row(
            children: [
              Hero(
                tag: '${champion.championId}Icon',
                child: Widgets.ShadowAvatar(
                  imageUrl: champion.iconUrl,
                  size: 36,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          this.buildAppBar(context),
          this.buildList(context),
        ],
      ),
    );
  }
}

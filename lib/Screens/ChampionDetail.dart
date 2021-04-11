import 'package:flutter/material.dart';

import '../Widgets/index.dart' as Widgets;
import '../Models/index.dart' as Models;

class ChampionDetail extends StatelessWidget {
  static const routeName = '/champion';

  @override
  Widget build(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as Models.Champion;
    final size = MediaQuery.of(context).size;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
            forceElevated: true,
            elevation: 7,
            pinned: true,
            snap: true,
            floating: true,
            backgroundColor: Color(0xFF0e242f),
            flexibleSpace: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: statusBarHeight,
                  width: size.width,
                ),
                Widgets.FastImage(
                  imageUrl: champion.headerUrl,
                  height: size.width / 2,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            expandedHeight: size.width / 2,
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildListDelegate(
              [
                Row(
                  children: [
                    Hero(
                      tag: '${champion.championId}Icon',
                      child: Widgets.ShadowAvatar(
                        imageUrl: champion.iconUrl,
                        radius: 36,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;

class ChampionStats extends StatelessWidget {
  const ChampionStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    var fallOffName = 'Range';

    if (champion.damageFallOffRange > 0) {
      fallOffName = 'Fall Off';
    }

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          Text('Damage : ${champion.weaponDamage.toInt()}'),
          Text('Fire Rate : ${champion.fireRate}/sec'),
          Text('$fallOffName : ${champion.damageFallOffRange.toInt().abs()}'),
        ],
      ),
    );
  }
}

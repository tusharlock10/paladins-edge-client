import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionHeading extends ConsumerWidget {
  const ChampionHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final textTheme = Theme.of(context).textTheme.headline1;
    final isLightTheme =
        ref.read(providers.auth).settings.themeMode == ThemeMode.light;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Hero(
            tag: '${champion.championId}Icon',
            child: widgets.ElevatedAvatar(
              imageUrl: champion.iconUrl,
              size: 42,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      champion.name.toUpperCase(),
                      style: textTheme?.copyWith(
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      champion.title.toUpperCase(),
                      style: textTheme?.copyWith(
                        color: isLightTheme
                            ? const Color(0xff5c5c5c)
                            : const Color(0xffb4fb26),
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Wrap(
                        children: champion.tags.map(
                          (tag) {
                            return widgets.TextChip(
                              text: tag.name,
                              spacing: 5,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

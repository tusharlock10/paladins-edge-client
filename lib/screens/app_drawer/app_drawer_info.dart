import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:url_launcher/url_launcher_string.dart";

class AppDrawerInfo extends StatelessWidget {
  const AppDrawerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final packageInfo = snapshot.data;

        if (packageInfo == null) {
          return const SizedBox();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Paladins Edge",
              style: textTheme.bodyLarge?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgets.TextChip(
                  color: Colors.deepPurple,
                  text: "v${packageInfo.version}",
                  spacing: 5,
                ),
                widgets.TextChip(
                  color: Colors.green,
                  text: constants.releaseTag,
                  spacing: 5,
                ),
                widgets.TextChip(
                  color: Colors.cyan,
                  text: constants.AppType.shortAppType,
                  spacing: 5,
                ),
              ],
            ),
            IconButton(
              iconSize: 20,
              tooltip: "View on GitHub",
              splashRadius: 22,
              icon: const Icon(FeatherIcons.github),
              onPressed: () => launchUrlString(constants.githubLink),
            ),
          ],
        );
      },
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/screens/player_detail/player_detail_filter_tab.dart";
import "package:paladinsedge/screens/player_detail/player_detail_sort_tab.dart";
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;

void showPlayerDetailFilterModal(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final width = utilities.responsiveCondition(
    context,
    desktop: screenWidth / 2.5,
    tablet: screenWidth / 1.5,
    mobile: screenWidth,
  );

  showModalBottomSheet(
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) => const _PlayerDetailFilterModal(),
    constraints: BoxConstraints(maxWidth: width),
  );
}

class _PlayerDetailFilterModal extends HookWidget {
  const _PlayerDetailFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final brightness = Theme.of(context).brightness;

    // Hooks
    final labelColor = useMemoized(
      () {
        return brightness == Brightness.light
            ? theme.themeMaterialColor
            : theme.themeMaterialColor.shade50;
      },
      [brightness],
    );

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3),
                bottomRight: Radius.circular(3),
                topLeft: Radius.circular(12.5),
                topRight: Radius.circular(12.5),
              ),
            ),
            child: TabBar(
              indicatorColor: labelColor,
              labelColor: labelColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              labelPadding: const EdgeInsets.all(0),
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FeatherIcons.filter, size: 18),
                      SizedBox(width: 10),
                      Text("Filter", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FeatherIcons.arrowUp, size: 20),
                      SizedBox(width: 10),
                      Text("Sort", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                PlayerDetailFilterTab(),
                PlayerDetailSortTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

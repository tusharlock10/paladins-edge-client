import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/loadouts/loadout_item.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:responsive_framework/responsive_framework.dart';

class Loadouts extends HookConsumerWidget {
  static const routeName = '/loadouts';
  const Loadouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final loadoutProvider = ref.read(providers.loadout);
    final playerId = ref.read(providers.auth).player?.playerId;
    final loadouts = ref.watch(providers.loadout.select((_) => _.loadouts));
    final isGettingLoadouts =
        ref.watch(providers.loadout.select((_) => _.isGettingLoadouts));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final crossAxisCount = utilities.responsiveCondition(
      context,
      desktop: 2,
      tablet: 2,
      mobile: 1,
    );
    final double horizontalPadding = utilities.responsiveCondition(
      context,
      desktop: 30,
      tablet: 30,
      mobile: 10,
    );

    // State
    final hideLoadoutFab = useState(false);

    // Effects
    useEffect(
      () {
        if (playerId != null) {
          loadoutProvider.getPlayerLoadouts(
            playerId: playerId,
            championId: champion.championId,
          );
        }

        return loadoutProvider.resetPlayerLoadouts;
      },
      [],
    );

    // Methods
    final onCreate = useCallback(
      () => Navigator.of(context).pushNamed(
        screens.CreateLoadout.routeName,
        arguments:
            data_classes.CreateLoadoutScreenArguments(champion: champion),
      ),
      [],
    );

    final onEdit = useCallback(
      (models.Loadout loadout) => Navigator.of(context).pushNamed(
        screens.CreateLoadout.routeName,
        arguments: data_classes.CreateLoadoutScreenArguments(
          champion: champion,
          loadout: loadout,
        ),
      ),
      [],
    );

    final onRefresh = useCallback(
      () async {
        if (playerId != null) {
          return await loadoutProvider.getPlayerLoadouts(
            playerId: playerId,
            championId: champion.championId,
            forceUpdate: true,
          );
        }
      },
      [playerId],
    );

    // TODO: Add floating SliverAppBar like in Home screen
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 90,
        child: AnimatedSlide(
          offset:
              hideLoadoutFab.value ? const Offset(0, 2) : const Offset(0, 0),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: onCreate,
            elevation: 4,
            hoverElevation: 6,
            focusElevation: 8,
            backgroundColor: theme.themeMaterialColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 2),
                Text(
                  'Create',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            isExtended: true,
          ),
        ),
      ),
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Loadouts'),
            Text(
              champion.name,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: isGettingLoadouts
          ? const widgets.LoadingIndicator(
              size: 36,
              center: true,
            )
          : widgets.Refresh(
              onRefresh: onRefresh,
              child: loadouts != null
                  ? ResponsiveGridView.builder(
                      padding: EdgeInsets.only(
                        right: horizontalPadding,
                        left: horizontalPadding,
                        top: 20,
                        bottom: 70,
                      ),
                      itemCount: loadouts.length,
                      gridDelegate: ResponsiveGridDelegate(
                        childAspectRatio: LoadoutItem.loadoutAspectRatio,
                        crossAxisExtent: (MediaQuery.of(context).size.width -
                                horizontalPadding * 2) /
                            crossAxisCount,
                      ),
                      itemBuilder: (_, index) {
                        final loadout = loadouts[index];

                        return GestureDetector(
                          onTap: () => onEdit(loadout),
                          child: AbsorbPointer(
                            absorbing: true,
                            child: LoadoutItem(
                              loadout: loadout,
                              champion: champion,
                            ),
                          ),
                        );
                      },
                    )
                  : const Text('Unable to fetch loadouts'),
            ),
    );
  }
}

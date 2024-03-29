import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/champion_detail/champion_detail_abilities.dart";
import "package:paladinsedge/screens/champion_detail/champion_detail_app_bar.dart";
import "package:paladinsedge/screens/champion_detail/champion_detail_heading.dart";
import "package:paladinsedge/screens/champion_detail/champion_detail_loadout_cards.dart";
import "package:paladinsedge/screens/champion_detail/champion_detail_lore.dart";
import "package:paladinsedge/screens/champion_detail/champion_detail_player_stats.dart";
import "package:paladinsedge/screens/champion_detail/champion_detail_talents.dart";
import "package:paladinsedge/screens/champion_detail/champion_detail_title_label.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ChampionDetail extends HookConsumerWidget {
  static const routeName = "champion";
  static const routePath = "champion/:championId";
  final int championId;

  const ChampionDetail({
    required this.championId,
    Key? key,
  }) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        pageBuilder: _routeBuilder,
        routes: routes,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final player = ref.watch(providers.auth.select((_) => _.userPlayer));
    final championsProvider = ref.read(providers.champions);
    final champions = ref.watch(providers.champions.select((_) => _.champions));
    final isLoadingCombinedChampions = ref.watch(
      providers.champions.select((_) => _.isLoadingCombinedChampions),
    );

    // State
    final hideLoadoutFab = useState(false);

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final champion = championsProvider.findChampion(championId);

    // Effects
    useEffect(
      () {
        if (champions.isEmpty) {
          championsProvider.loadCombinedChampions();
        }

        return;
      },
      [champions],
    );

    // Methods
    final onScrollNotification = useCallback(
      (ScrollNotification notification) {
        if (notification is ScrollEndNotification && hideLoadoutFab.value) {
          hideLoadoutFab.value = false;

          return true;
        }
        if ((notification is ScrollUpdateNotification) &&
            (notification.scrollDelta ?? 0).abs() > 1.2 &&
            !hideLoadoutFab.value) {
          hideLoadoutFab.value = true;
        }

        return true;
      },
      [],
    );

    final onLoadoutPressHelper = useCallback(
      () {
        if (champion == null || player == null) return;
        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.championLoadouts,
          {"champion": champion.name},
        );
        utilities.Navigation.navigate(
          context,
          screens.Loadouts.routeName,
          params: {
            "championId": champion.championId.toString(),
            "playerId": player.playerId,
          },
        );
      },
      [],
    );

    final onLoadoutPress = useCallback(
      () {
        if (isGuest) {
          widgets.showLoginModal(data_classes.ShowLoginModalOptions(
            context: context,
            loginCta: constants.LoginCTA.loadoutFab,
          ));
        } else {
          onLoadoutPressHelper();
        }
      },
      [isGuest],
    );

    return champion == null
        ? isLoadingCombinedChampions
            ? const Scaffold(
                body: widgets.LoadingIndicator(
                  lineWidth: 2,
                  size: 28,
                  label: Text("Getting champion"),
                ),
              )
            : const screens.NotFound()
        : Scaffold(
            floatingActionButton: SizedBox(
              height: 50,
              width: 108,
              child: AnimatedSlide(
                offset: hideLoadoutFab.value
                    ? const Offset(0, 2)
                    : const Offset(0, 0),
                duration: const Duration(milliseconds: 300),
                child: widgets.InteractiveCard(
                  onTap: onLoadoutPress,
                  elevation: 4,
                  hoverElevation: 6,
                  color: theme.themeMaterialColor,
                  borderRadius: 25,
                  child: Center(
                    child: Text(
                      "Loadouts",
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: isLoadingCombinedChampions
                ? const widgets.LoadingIndicator(
                    lineWidth: 2,
                    size: 28,
                    label: Text("Getting champion"),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: onScrollNotification,
                    child: CustomScrollView(
                      slivers: [
                        ChampionDetailAppBar(champion: champion),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              ChampionDetailHeading(champion: champion),
                              const ChampionDetailTitleLabel(label: "Lore"),
                              ChampionDetailLore(champion: champion),
                              const ChampionDetailTitleLabel(
                                label: "Talents",
                              ),
                              ChampionDetailTalents(champion: champion),
                              const ChampionDetailTitleLabel(
                                label: "Abilities",
                              ),
                              ChampionDetailAbilities(champion: champion),
                              const ChampionDetailTitleLabel(
                                label: "Loadout Cards",
                              ),
                              ChampionDetailLoadoutCards(
                                champion: champion,
                              ),
                              const ChampionDetailTitleLabel(
                                label: "Your Stats",
                              ),
                              ChampionDetailPlayerStats(champion: champion),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
  }

  static Page _routeBuilder(_, GoRouterState state) {
    final param = state.pathParameters["championId"];
    if (param == null) return const CupertinoPage(child: screens.NotFound());

    final championId = int.tryParse(param);
    if (championId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    return CupertinoPage(
      child: widgets.PopShortcut(child: ChampionDetail(championId: championId)),
    );
  }
}

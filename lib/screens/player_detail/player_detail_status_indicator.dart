import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailStatusIndicator extends HookConsumerWidget {
  const PlayerDetailStatusIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final isLoadingPlayerStatus =
        ref.watch(providers.players.select((_) => _.isLoadingPlayerStatus));
    final playerStatus =
        ref.watch(providers.players.select((_) => _.playerStatus));

    // Variables
    final status = playerStatus?.status;
    final isOnline = status?.toLowerCase() != "offline" &&
        status?.toLowerCase() != "unknown" &&
        status != null;
    final isUnknown = status?.toLowerCase() == "unknown" || status == null;
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final getLastSeen = useCallback(
      () {
        if (player == null) return "";

        final lastLoginDate = player.lastLoginDate;
        final duration = DateTime.now().difference(lastLoginDate);
        if (duration > const Duration(days: 1)) {
          return Jiffy(lastLoginDate).yMMMd;
        }

        return Jiffy(lastLoginDate).fromNow();
      },
      [player],
    );

    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: isLoadingPlayerStatus || status == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widgets.LoadingIndicator(
                      size: 12,
                      lineWidth: 1.2,
                      color: textTheme.bodyText1?.color,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Status",
                      style: textTheme.bodyText1?.copyWith(fontSize: 14),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 10,
                          width: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                              color: isOnline
                                  ? Colors.green
                                  : isUnknown
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isOnline
                              ? "Online"
                              : isUnknown
                                  ? "Unknown"
                                  : "Offline",
                        ),
                      ],
                    ),
                    Text(
                      isOnline ? status : getLastSeen(),
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

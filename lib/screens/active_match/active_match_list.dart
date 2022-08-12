import "package:flutter/material.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/screens/active_match/active_match_player.dart";

class ActiveMatchList extends StatelessWidget {
  final api.PlayerStatusResponse playerStatus;
  const ActiveMatchList({
    required this.playerStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final playersInfoTeam1 = playerStatus.match?.playersInfo.where(
          (_) => _.team == 1,
        ) ??
        [];
    final playersInfoTeam2 = playerStatus.match?.playersInfo.where(
          (_) => _.team == 2,
        ) ??
        [];

    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          const SizedBox(height: 30),
          if (playerStatus.match != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  playerStatus.status,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SelectableText(
                  "${playerStatus.match?.map}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Team 1",
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          ...playersInfoTeam1.map(
            (playerInfo) {
              return ActiveMatchPlayer(
                playerInfo: playerInfo,
              );
            },
          ).toList(),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Team 2",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          ...playersInfoTeam2.map(
            (playerInfo) {
              return ActiveMatchPlayer(
                playerInfo: playerInfo,
              );
            },
          ).toList(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

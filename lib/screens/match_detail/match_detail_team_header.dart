import "package:flutter/material.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;

class MatchDetailTeamHeader extends StatelessWidget {
  final data_classes.MatchTeamStats teamStats;
  final bool isWinningTeam;

  const MatchDetailTeamHeader({
    required this.teamStats,
    required this.isWinningTeam,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isWinningTeam ? "WON" : "LOST",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: isWinningTeam ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            "${teamStats.kills} / ${teamStats.deaths} / ${teamStats.assists}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

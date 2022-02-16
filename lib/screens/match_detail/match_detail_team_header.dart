import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;

class MatchDetailTeamHeader extends StatelessWidget {
  final Map<String, int> teamStats;
  final bool isWinningTeam;
  final models.MatchPlayer matchPlayer;

  const MatchDetailTeamHeader({
    required this.teamStats,
    required this.isWinningTeam,
    required this.matchPlayer,
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
            isWinningTeam ? 'WON' : 'LOST',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: isWinningTeam ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            'Team ${matchPlayer.team}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            '${teamStats['kills']} / ${teamStats['deaths']} / ${teamStats['assists']}',
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
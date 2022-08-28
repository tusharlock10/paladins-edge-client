class CommonMatchesStats {
  int sameTeam = 0;
  int oppositeTeam = 0;
  double sameTeamWR = 0;

  String get sameTeamWRFormatted => sameTeamWR.toStringAsPrecision(3);
}

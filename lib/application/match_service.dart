import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/data/match_repository.dart';
import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:flutter/material.dart';

class MatchService {
  final MatchRepository matchRepository = MatchRepository();

  Future<List<UserMatch>> getUserMatches({
    required BuildContext context,
    DateTime? date,
  }) async {
    int userId =
        AuthenticationService.fromProvider(context, listen: false).user.id;
    try {
      List<dynamic> matches =
          await matchRepository.getUserMatches(context: context, date: date);
      return matches.map((match) {
        List<dynamic> scores = match['score'];
        match['userScore'] =
            scores.firstWhere((score) => score['userId'] == userId);
        match['opponentScore'] =
            scores.firstWhere((score) => score['userId'] != userId);
        (match as Map<String, dynamic>).remove('score');
        return UserMatch.fromJson(match);
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return List.empty();
    }
  }

  Future<List<dynamic>> getCountMatches({
    required BuildContext context,
    required bool monthlyStandings,
  }) async {
    try {
      return await matchRepository.getCountMatches(
        context: context,
        monthlyStandings: monthlyStandings,
      );
    } catch (e) {
      debugPrint(e.toString());
      return List.empty();
    }
  }

  Future<bool> createMatch({
    required BuildContext context,
    required int nbTouches,
    required int opponentId,
    required int givenTouches,
    required int receivedTouches,
    required bool isWin,
  }) async {
    try {
      await matchRepository.createMatch(
        context: context,
        nbTouches: nbTouches,
        opponentId: opponentId,
        givenTouches: givenTouches,
        receivedTouches: receivedTouches,
        isWin: isWin,
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

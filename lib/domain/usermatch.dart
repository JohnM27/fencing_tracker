import 'package:fencing_tracker/domain/user.dart';

class UserMatch {
  final int id;
  final DateTime date;
  final int nbTouches;
  final User opponent;
  final int givenTouches;
  final int receivedTouches;
  final bool isVictory;

  const UserMatch({
    required this.id,
    required this.date,
    required this.nbTouches,
    required this.opponent,
    required this.givenTouches,
    required this.receivedTouches,
    required this.isVictory,
  });

  UserMatch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['date']),
        nbTouches = json['nbTouches'],
        opponent = User.fromJson(json['opponentScore']['user']),
        givenTouches = json['userScore']['givenTouches'],
        receivedTouches = json['opponentScore']['givenTouches'],
        isVictory = json['userScore']['isWin'];

  bool isOneTouchDifference() {
    return isVictory
        ? receivedTouches == nbTouches - 1
        : givenTouches == nbTouches - 1;
  }

  bool isVictoryNoTouchesReceived() {
    return isVictory && receivedTouches == 0;
  }

  static int getNbVictories(List<UserMatch> matches) {
    int result = 0;
    for (var match in matches) {
      if (match.isVictory) {
        result++;
      }
    }
    return result;
  }

  static int getNbDefeats(List<UserMatch> matches) {
    int result = 0;
    for (var match in matches) {
      if (!match.isVictory) {
        result++;
      }
    }
    return result;
  }

  static double getWinrate(List<UserMatch> matches) {
    int nbVictories = UserMatch.getNbVictories(matches);
    return (nbVictories * 100) / matches.length;
  }

  static int getIndice(List<UserMatch> matches) {
    int givenTouches = 0;
    int receivedTouches = 0;

    for (var match in matches) {
      givenTouches += match.givenTouches;
      receivedTouches += match.receivedTouches;
    }
    return givenTouches - receivedTouches;
  }
}

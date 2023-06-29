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
}

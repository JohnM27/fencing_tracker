import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/domain/user.dart';
import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:flutter/material.dart';

class HistoryOpponent extends StatelessWidget {
  final User opponent;

  const HistoryOpponent({
    super.key,
    required Object opponentObject,
  }) : opponent = opponentObject as User;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(opponent.username),
      ),
      body: FutureBuilder(
        future: MatchService().getUserMatches(context: context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          List<UserMatch> matches = snapshot.data;
          matches.removeWhere((element) => element.opponent != opponent);
          matches.sort(
            (a, b) => a.date.compareTo(b.date),
          );
          matches = List.from(matches.reversed);

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: List.generate(matches.length, (index) {
              UserMatch match = matches[index];

              return Text(
                  '${match.isVictory ? 'V' : 'D'} ${match.givenTouches}-${match.receivedTouches} ; ${match.date}');
            }),
          );
        },
      ),
    );
  }
}

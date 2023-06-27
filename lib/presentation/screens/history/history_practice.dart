import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:fencing_tracker/presentation/components/match_tile.dart';
import 'package:flutter/material.dart';

class HistoryPracticeScreen extends StatelessWidget {
  final DateTime date;

  const HistoryPracticeScreen({
    super.key,
    required Object dateObject,
  }) : date = dateObject as DateTime;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MatchService().getUserMatches(
          context: context,
          date: date,
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          List<UserMatch> matches = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title:
                  Text('Entraînement: ${date.day}/${date.month}/${date.year}'),
            ),
            body: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                ...List.generate(
                  matches.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MatchTile(match: matches[index]),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}

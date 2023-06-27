import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:fencing_tracker/utils/custom_datetime.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryDate extends StatelessWidget {
  const HistoryDate({super.key});

  String stringifyDate(DateTime date) {
    return '${date.day < 10 ? '0${date.day}' : date.day}/${date.month < 10 ? '0${date.month}' : date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MatchService().getUserMatches(context: context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        List<UserMatch> matches = snapshot.data;
        List<DateTime> trainingDates = List.empty(growable: true);

        for (var match in matches) {
          DateTime date =
              DateTime(match.date.year, match.date.month, match.date.day);
          if (!trainingDates.contains(date)) {
            trainingDates.add(date);
          }
        }

        return ListView(
          padding: const EdgeInsets.all(24.0),
          children: List.generate(trainingDates.length, (index) {
            DateTime date = trainingDates.reversed.toList()[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == trainingDates.length - 1 ? 0.0 : 12.0,
              ),
              child: ListTile(
                title: Text('${date.weekdayString} ${stringifyDate(date)}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                tileColor: CustomColors.purple.withOpacity(0.25),
                onTap: () => context.go(
                  '/history/practice',
                  extra: date,
                ),
              ),
            );
          }),
        );

        // return ListView(children: [
        //   ...List.generate(matches.length, (index) {
        //     UserMatch match = matches[index];

        //     return Text(
        //         'VS ${match.opponent.username} ; ${match.isVictory ? 'V' : 'D'} ${match.givenTouches}-${match.receivedTouches} ; ${match.date}');
        //   }),
        //   const SizedBox(height: 24.0),
        //   ...List.generate(
        //       trainingDates.length, (index) => Text(trainingDates[index])),
        // ]);
      },
    );
  }
}

import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:fencing_tracker/utils/custom_datetime.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StandingsWinrate extends StatefulWidget {
  const StandingsWinrate({super.key});

  @override
  State<StandingsWinrate> createState() => _StandingsWinrateState();
}

class _StandingsWinrateState extends State<StandingsWinrate> {
  bool monthlyStandings = true;

  Color getTileColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFD4AF37).withOpacity(0.75);
      case 1:
        return const Color(0xFFA8A9AD).withOpacity(0.75);
      case 2:
        return const Color(0xFFAA7042).withOpacity(0.75);
      default:
        return CustomColors.purple.withOpacity(0.25);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          children: [
            ChoiceChip(
              label: Text(DateTime.now().monthString),
              selected: monthlyStandings,
              onSelected: (value) => setState(() {
                monthlyStandings = value;
              }),
            ),
            ChoiceChip(
              label: Text('Saison ${Utils.getCurrentSeason2Year()}'),
              selected: !monthlyStandings,
              onSelected: (value) => setState(() {
                monthlyStandings = !value;
              }),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: FutureBuilder(
            future: MatchService().getCountMatches(
              context: context,
              monthlyStandings: monthlyStandings,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              List<dynamic> data = [...snapshot.data];
              data.sort((a, b) => a['winrate'] > b['winrate'] ? -1 : 1);
              data.removeWhere((element) => element['totalMatches'] < 4);

              return ListView(
                physics: const ClampingScrollPhysics(),
                children: List.generate(data.length, (index) {
                  dynamic element = data[index];

                  return Card(
                    shape: const RoundedRectangleBorder(),
                    margin: EdgeInsets.only(
                      bottom: index == data.length - 1 ? 0.0 : 12.0,
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text('${index + 1}: ${element['username']}'),
                          const Spacer(),
                          Text('${element['winrate']} %'),
                        ],
                      ),
                      tileColor: getTileColor(index),
                      onTap: () => displayDialog(context, element, index),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  void displayDialog(
    BuildContext context,
    dynamic data,
    int index,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            children: [
              CircularPercentIndicator(
                radius: 48.0,
                percent: data['winrate'] / 100,
                lineWidth: 8.0,
                backgroundColor: CustomColors.red,
                progressColor: CustomColors.green,
                header: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    data['username'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                center: Text(
                  '${data['winrate']} %',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Matches total: ${data['totalMatches']}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          );
        });
  }
}

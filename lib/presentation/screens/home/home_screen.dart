import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/presentation/components/top_display.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:fencing_tracker/utils/custom_datetime.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool monthlyStandings = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

        List<dynamic> dataFiveO = [...snapshot.data];
        dataFiveO.sort((a, b) => a['totalFiveO'] > b['totalFiveO'] ? -1 : 1);

        return ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          children: [
            Text(
              'Classements du club',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24.0),
            Text(
              'Top ratio Victoires / Défaites:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
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
            const SizedBox(height: 12.0),
            TopDisplay(
              data: {
                for (var element in data)
                  element['username']: element['winrate']
              },
              dataTotal: {
                for (var element in data)
                  element['username']: element['totalMatches']
              },
              unit: '%',
            ),
            const SizedBox(height: 24.0),
            Text(
              'Top victoires 5-0 (saison ${Utils.getCurrentSeason2Year()}):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            TopDisplay(data: {
              for (var element in dataFiveO)
                element['username']: element['totalFiveO']
            }),
            const SizedBox(height: 24.0),
          ],
        );
      },
    );
  }
}

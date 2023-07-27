import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:fencing_tracker/presentation/components/stats_chart.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:fencing_tracker/utils/custom_datetime.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<String> labelsSeasonDropdown = Utils.getListOfSeasons();
  int selectedMonth = DateTime.now().month - 1;
  int selectedSeason = Utils.getListOfSeasons()
      .indexWhere((season) => season == Utils.getCurrentSeason2Year());
  bool onlySelectedMonth = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MatchService().getUserMatchesRange(
        context: context,
        onlySelectedMonth: onlySelectedMonth,
        month: selectedMonth,
        season: selectedMonth > 8
            ? int.parse(labelsSeasonDropdown[selectedSeason].substring(0, 4))
            : int.parse(labelsSeasonDropdown[selectedSeason].substring(5)),
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        List<UserMatch> matches = snapshot.data;
        List<UserMatch> matchesOneTouchDifference =
            matches.where((element) => element.isOneTouchDifference()).toList();

        double winrate = UserMatch.getWinrate(matches);
        double winrateOneTouchDifference =
            UserMatch.getWinrate(matchesOneTouchDifference);

        int indice = UserMatch.getIndice(matches);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedMonth,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mois',
                      ),
                      items: List.generate(monthsList.length, (index) {
                        return DropdownMenuItem(
                          value: index,
                          child: Text(monthsList[index]),
                        );
                      }),
                      onChanged: (value) => setState(() {
                        selectedMonth = value ?? 0;
                      }),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedSeason,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Saison',
                      ),
                      items:
                          List.generate(labelsSeasonDropdown.length, (index) {
                        return DropdownMenuItem(
                          value: index,
                          child: Text(labelsSeasonDropdown[index]),
                        );
                      }),
                      onChanged: (value) => setState(() {
                        selectedSeason = value ?? 0;
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 48.0,
                      percent: winrate / 100,
                      lineWidth: 8.0,
                      backgroundColor: CustomColors.red,
                      progressColor: CustomColors.green,
                      header: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Ratio V/D',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      center: Text(
                        '${winrate.toStringAsFixed(2)} %',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      footer: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          'Matches total: ${matches.length}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 48.0,
                      percent: winrateOneTouchDifference / 100,
                      lineWidth: 8.0,
                      backgroundColor: CustomColors.red,
                      progressColor: CustomColors.green,
                      header: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Ratio V/D (1 touche d’écart)',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      center: Text(
                        '${winrateOneTouchDifference.toStringAsFixed(2)} %',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      footer: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          'Matches total: ${matchesOneTouchDifference.length}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.purple),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Indice global (TD - TR):',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${indice >= 0 ? '+$indice' : indice}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.purple),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nb 5-0:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${matches.where((match) => match.isVictoryNoTouchesReceived() && match.nbTouches == 5).length}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.purple),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nb 15-0:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${matches.where((match) => match.isVictoryNoTouchesReceived() && match.nbTouches == 15).length}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              matches.isNotEmpty
                  ? Expanded(
                      child: StatsChart(matches: matches),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsChart extends StatefulWidget {
  final List<UserMatch> matches;

  const StatsChart({
    super.key,
    required this.matches,
  });

  @override
  State<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {
  bool graphDisplayRatio = true;

  Map<DateTime, List<UserMatch>> groupMatchesByDay(List<UserMatch> matches) {
    Map<DateTime, List<UserMatch>> matchesByDay = {};

    for (var match in matches) {
      DateTime dayKey =
          DateTime(match.date.year, match.date.month, match.date.day);

      if (matchesByDay.containsKey(dayKey)) {
        matchesByDay[dayKey]!.add(match);
      } else {
        matchesByDay[dayKey] = [match];
      }
    }

    return matchesByDay;
  }

  String getGraphDisplayMode(bool graphDisplayRatio) {
    return graphDisplayRatio ? 'Radio V/D' : 'Indice';
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta,
      Map<DateTime, List<UserMatch>> matchesByDay) {
    DateTime currentKey = matchesByDay.keys.elementAt(value.toInt());

    Widget text = Text('${currentKey.day}/${currentKey.month}');

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<UserMatch>> matchesByDay =
        groupMatchesByDay(widget.matches);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: LineChart(
            graphDisplayRatio
                ? ratioData(matchesByDay)
                : indiceData(matchesByDay),
          ),
        ),
        const SizedBox(height: 12.0),
        OutlinedButton(
          onPressed: () => setState(() {
            graphDisplayRatio = !graphDisplayRatio;
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Graphique: ${getGraphDisplayMode(graphDisplayRatio)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }

  LineChartData indiceData(Map<DateTime, List<UserMatch>> matchesByDay) {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(matchesByDay.length, (index) {
            DateTime currentKey = matchesByDay.keys.elementAt(index);
            return FlSpot(
              index.toDouble(),
              UserMatch.getIndice(matchesByDay[currentKey]!).toDouble(),
            );
          }),
          isCurved: true,
          color: CustomColors.purple,
          belowBarData: BarAreaData(
            show: true,
            color: CustomColors.purple.withOpacity(0.2),
          ),
        ),
      ],
      // minY: 0,
      // maxY: 100,
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(
              value,
              meta,
              matchesByDay,
            ),
          ),
        ),
        leftTitles: const AxisTitles(
          axisNameWidget: Text('Indice'),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
    );
  }

  LineChartData ratioData(Map<DateTime, List<UserMatch>> matchesByDay) {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(matchesByDay.length, (index) {
            DateTime currentKey = matchesByDay.keys.elementAt(index);
            return FlSpot(
              index.toDouble(),
              UserMatch.getWinrate(matchesByDay[currentKey]!),
            );
          }),
          isCurved: true,
          color: CustomColors.purple,
          belowBarData: BarAreaData(
            show: true,
            color: CustomColors.purple.withOpacity(0.2),
          ),
        ),
      ],
      minY: 0,
      maxY: 100,
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(
              value,
              meta,
              matchesByDay,
            ),
          ),
        ),
        leftTitles: const AxisTitles(
          axisNameWidget: Text('Ratio V/D (%)'),
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            reservedSize: 42,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
    );
  }
}

import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

class StandingsFiveO extends StatefulWidget {
  const StandingsFiveO({super.key});

  @override
  State<StandingsFiveO> createState() => _StandingsFiveOState();
}

class _StandingsFiveOState extends State<StandingsFiveO> {
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
    return FutureBuilder(
      future: MatchService().getCountMatches(
        context: context,
        monthlyStandings: false,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        List<dynamic> data = [...snapshot.data];
        data.sort((a, b) => a['totalFiveO'] > b['totalFiveO'] ? -1 : 1);
        data.removeWhere((element) => element['totalFiveO'] < 1);

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
                    Text('${element['totalFiveO']}'),
                  ],
                ),
                tileColor: getTileColor(index),
              ),
            );
          }),
        );
      },
    );
  }
}

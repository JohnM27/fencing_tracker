import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/presentation/components/top_display.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MatchService().getTopVictory(context: context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          List<dynamic> data = snapshot.data;
          data.sort((a, b) => a['winrate'] > b['winrate'] ? -1 : 1);
          data.removeWhere((element) => element['totalMatches'] < 4);

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
              TopDisplay(
                data: {
                  for (var element in data)
                    element['username']: element['winrate']
                },
                dataTotal: {
                  for (var element in data)
                    element['username']: element['totalMatches']
                },
              ),
              const SizedBox(height: 24.0),
              Text(
                'Top victoires 5-0:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 200.0,
                color: CustomColors.purple,
                child: Center(
                  child: Text(
                    'A venir',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         children: [
              //           ListTile(
              //             title: Row(
              //               children: [
              //                 Text('${dataList[0]['username']}'),
              //                 const Spacer(),
              //                 Text('${dataList[0]['winrate']} %'),
              //               ],
              //             ),
              //             tileColor: const Color(0xFFD4AF37).withOpacity(0.75),
              //           ),
              //           const SizedBox(height: 8.0),
              //           ListTile(
              //             title: Row(
              //               children: [
              //                 Text('${dataList[1]['username']}'),
              //                 const Spacer(),
              //                 Text('${dataList[1]['winrate']} %'),
              //               ],
              //             ),
              //             tileColor: const Color(0xFFA8A9AD).withOpacity(0.75),
              //           ),
              //           const SizedBox(height: 8.0),
              //           ListTile(
              //             title: Row(
              //               children: [
              //                 Text('${dataList[2]['username']}'),
              //                 const Spacer(),
              //                 Text('${dataList[2]['winrate']} %'),
              //               ],
              //             ),
              //             tileColor: const Color(0xFFAA7042).withOpacity(0.75),
              //           ),
              //           const SizedBox(height: 8.0),
              //         ],
              //       ),
              //     ),
              //     // const SizedBox(width: 24.0),
              //     // Expanded(
              //     //   child: Column(
              //     //     children: [
              //     //       const Text('Top 5-0'),
              //     //       ListTile(
              //     //         title: const Text('Olivier Jeandel'),
              //     //         tileColor: const Color(0xFFD4AF37).withOpacity(0.75),
              //     //       ),
              //     //       const SizedBox(height: 8.0),
              //     //       ListTile(
              //     //         title: const Text('Olivier Jeandel'),
              //     //         tileColor: const Color(0xFFA8A9AD).withOpacity(0.75),
              //     //       ),
              //     //       const SizedBox(height: 8.0),
              //     //       ListTile(
              //     //         title: const Text('Olivier Jeandel'),
              //     //         tileColor: const Color(0xFFAA7042).withOpacity(0.75),
              //     //       ),
              //     //       const SizedBox(height: 8.0),
              //     //     ],
              //     //   ),
              //     // ),
              //   ],
              // )
              const SizedBox(height: 24.0),
            ],
          );
        });
  }
}

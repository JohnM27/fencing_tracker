import 'package:fencing_tracker/application/match_service.dart';
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

          List<dynamic> dataList = snapshot.data;
          dataList.sort(
              (a, b) => a['_count']['score'] > b['_count']['score'] ? -1 : 1);
          for (var element in dataList) {
            print(element);
          }

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                'Top victoires',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text('${dataList[0]['username']}'),
                              const Spacer(),
                              Text('${dataList[0]['_count']['score']}'),
                            ],
                          ),
                          tileColor: const Color(0xFFD4AF37).withOpacity(0.75),
                        ),
                        const SizedBox(height: 8.0),
                        ListTile(
                          title: Row(
                            children: [
                              Text('${dataList[1]['username']}'),
                              const Spacer(),
                              Text('${dataList[1]['_count']['score']}'),
                            ],
                          ),
                          tileColor: const Color(0xFFA8A9AD).withOpacity(0.75),
                        ),
                        const SizedBox(height: 8.0),
                        ListTile(
                          title: Row(
                            children: [
                              Text('${dataList[2]['username']}'),
                              const Spacer(),
                              Text('${dataList[2]['_count']['score']}'),
                            ],
                          ),
                          tileColor: const Color(0xFFAA7042).withOpacity(0.75),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 24.0),
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       const Text('Top 5-0'),
                  //       ListTile(
                  //         title: const Text('Olivier Jeandel'),
                  //         tileColor: const Color(0xFFD4AF37).withOpacity(0.75),
                  //       ),
                  //       const SizedBox(height: 8.0),
                  //       ListTile(
                  //         title: const Text('Olivier Jeandel'),
                  //         tileColor: const Color(0xFFA8A9AD).withOpacity(0.75),
                  //       ),
                  //       const SizedBox(height: 8.0),
                  //       ListTile(
                  //         title: const Text('Olivier Jeandel'),
                  //         tileColor: const Color(0xFFAA7042).withOpacity(0.75),
                  //       ),
                  //       const SizedBox(height: 8.0),
                  //     ],
                  //   ),
                  // ),
                ],
              )
            ],
          );
        });
  }
}

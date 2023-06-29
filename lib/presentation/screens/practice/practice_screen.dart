import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:fencing_tracker/presentation/components/match_tile.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PracticeScreen extends StatelessWidget {
  final DateTime currentDate = DateTime.now();

  PracticeScreen({super.key});

  int getRatio(int nbMatches, int nbVictories) {
    return ((nbVictories * 100) / nbMatches).round();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MatchService().getUserMatches(
          context: context,
          date: DateTime.now(),
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          List<UserMatch> matches = snapshot.data;
          int nbVictories = UserMatch.getNbVictories(matches);
          int nbDefeats = UserMatch.getNbDefeats(matches);

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: matches.isEmpty
                      ? Text(
                          'Pas de matchs',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : ListView(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Derniers matchs:',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                OutlinedButton(
                                  onPressed: () => context.go(
                                    '/currentpractice/matchdetail',
                                    extra: matches,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(
                                      'Voir plus',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            ...List.generate(
                                matches.length < 5 ? matches.length : 5,
                                (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: MatchTile(match: matches[index]),
                              );
                            }),
                            const SizedBox(height: 4.0),
                            Text(
                              'Total matchs: ${matches.length}',
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8.0),
                            const Divider(),
                            const SizedBox(height: 12.0),
                            Text(
                              'Victoires / Défaites',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  '$nbVictories',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LinearProgressIndicator(
                                        value: getRatio(
                                                    matches.length, nbVictories)
                                                .toDouble() /
                                            100,
                                        color: CustomColors.green,
                                        backgroundColor: CustomColors.red,
                                      ),
                                      Text(
                                        '${getRatio(matches.length, nbVictories)}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Text(
                                  '$nbDefeats',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                ),
                const SizedBox(height: 24.0),
                OutlinedButton(
                  onPressed: () => context.go('/currentpractice/creatematch'),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nouveau match'.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

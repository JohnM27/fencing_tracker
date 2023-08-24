import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TopDisplay extends StatelessWidget {
  final Map<String, double> data;
  final Map<String, double>? dataTotal;
  final String unit;

  const TopDisplay({
    super.key,
    required this.data,
    this.dataTotal,
    this.unit = '',
  });

  String getCurrentStanding(BuildContext context) {
    AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);
    String username = authenticationService.user.username;
    int standing = data.keys.toList().indexOf(username) + 1;
    return standing == 0 ? 'N/A (4 matches requis)' : '$standing';
  }

  void displayDialog(BuildContext context, int index) {
    if (dataTotal == null) {
      return;
    }
    String currentKey = data.keys.elementAt(index);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            children: [
              CircularPercentIndicator(
                radius: 48.0,
                percent: data[currentKey]! / 100,
                lineWidth: 8.0,
                backgroundColor: CustomColors.red,
                progressColor: CustomColors.green,
                header: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    currentKey,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                center: Text(
                  '${data[currentKey]} %',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Matches total: ${dataTotal![currentKey]}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data.length > 1
            ? ListTile(
                title: Row(
                  children: [
                    Text(data.keys.elementAt(0)),
                    const Spacer(),
                    Text('${data[data.keys.elementAt(0)]} $unit'),
                  ],
                ),
                tileColor: const Color(0xFFD4AF37).withOpacity(0.75),
                onTap: () => displayDialog(context, 0),
              )
            : ListTile(
                title: const Text('N/A'),
                tileColor: CustomColors.purple.withOpacity(0.25),
              ),
        const SizedBox(height: 8.0),
        data.length > 2
            ? ListTile(
                title: Row(
                  children: [
                    Text(data.keys.elementAt(1)),
                    const Spacer(),
                    Text('${data[data.keys.elementAt(1)]} $unit'),
                  ],
                ),
                tileColor: const Color(0xFFA8A9AD).withOpacity(0.75),
                onTap: () => displayDialog(context, 1),
              )
            : ListTile(
                title: const Text('N/A'),
                tileColor: CustomColors.purple.withOpacity(0.25),
              ),
        const SizedBox(height: 8.0),
        data.length > 3
            ? ListTile(
                title: Row(
                  children: [
                    Text(data.keys.elementAt(2)),
                    const Spacer(),
                    Text('${data[data.keys.elementAt(2)]} $unit'),
                  ],
                ),
                tileColor: const Color(0xFFAA7042).withOpacity(0.75),
                onTap: () => displayDialog(context, 2),
              )
            : ListTile(
                title: const Text('N/A'),
                tileColor: CustomColors.purple.withOpacity(0.25),
              ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Text(
              'Classement actuel: ${getCurrentStanding(context)}',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () => context.go(
                '/fullstandings',
                extra: !(dataTotal == null),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Voir plus',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

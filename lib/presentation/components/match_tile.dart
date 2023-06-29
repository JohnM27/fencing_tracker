import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

class MatchTile extends StatelessWidget {
  final UserMatch match;

  const MatchTile({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: match.isVictory ? CustomColors.green : CustomColors.red,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      title: Row(
        children: [
          Text('${match.opponent.username}:'),
          const Spacer(),
          Text(
              '${match.isVictory ? 'V' : 'D'} ${match.givenTouches}-${match.receivedTouches}'),
        ],
      ),
      tileColor: CustomColors.purple.withOpacity(0.25),
    );
  }
}

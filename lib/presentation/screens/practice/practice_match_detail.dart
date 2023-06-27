import 'package:fencing_tracker/domain/usermatch.dart';
import 'package:fencing_tracker/presentation/components/match_tile.dart';
import 'package:flutter/material.dart';

class PracticeMatchDetail extends StatelessWidget {
  final List<UserMatch> matches;

  const PracticeMatchDetail({
    super.key,
    required Object matchesObject,
  }) : matches = matchesObject as List<UserMatch>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          return MatchTile(match: matches[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      ),
    );
  }
}

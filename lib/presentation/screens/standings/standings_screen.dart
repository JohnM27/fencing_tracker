import 'package:fencing_tracker/presentation/screens/standings/standings_five_o.dart';
import 'package:fencing_tracker/presentation/screens/standings/standings_winrate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StandingsScreen extends StatelessWidget {
  final bool _displayRatio;

  const StandingsScreen({
    super.key,
    required dynamic displayRatio,
  }) : _displayRatio =
            displayRatio ?? true; //bool.tryParse(displayRatio) ?? true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _displayRatio ? 0 : 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Classements complets'),
          actions: [
            IconButton(
              onPressed: () => context.go('/help'),
              icon: const Icon(Icons.help_outline),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'Ratio V / D'),
            Tab(text: 'Victoires 5-0'),
          ]),
        ),
        body: const Padding(
          padding: EdgeInsets.all(24.0),
          child: TabBarView(
            children: [
              StandingsWinrate(),
              StandingsFiveO(),
            ],
          ),
        ),
      ),
    );
  }
}

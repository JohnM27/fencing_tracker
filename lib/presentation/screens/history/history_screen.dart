import 'package:fencing_tracker/presentation/screens/history/history_date.dart';
import 'package:fencing_tracker/presentation/screens/history/history_people.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historique'),
          actions: [
            IconButton(
              onPressed: () => context.go('/help'),
              icon: const Icon(Icons.help_outline),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.calendar_month)),
            Tab(icon: Icon(Icons.group)),
          ]),
        ),
        body: const TabBarView(children: [
          HistoryDate(),
          HistoryPeople(),
        ]),
      ),
    );
  }
}

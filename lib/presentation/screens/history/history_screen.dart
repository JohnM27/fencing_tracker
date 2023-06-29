import 'package:fencing_tracker/presentation/screens/history/history_date.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historique'),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.calendar_month)),
            Tab(icon: Icon(Icons.group)),
          ]),
        ),
        body: const TabBarView(children: [
          HistoryDate(),
          Center(child: Text('TBD: Historique par adversaire')),
        ]),
      ),
    );
  }
}

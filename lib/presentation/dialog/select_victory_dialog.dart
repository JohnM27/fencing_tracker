import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectVictoryDialog extends StatelessWidget {
  const SelectVictoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(
        'Résultat',
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.all(24.0),
      children: [
        OutlinedButton(
          onPressed: () => context.pop(true),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Victoire',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        OutlinedButton(
          onPressed: () => context.pop(false),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Défaite',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}

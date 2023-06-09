import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();

  bool isInputValid() {
    return _usernameController.text != "" && _clubController.text != "";
  }

  void submitUser(BuildContext context) {
    // If input is not valid, then do nothing
    if (!isInputValid()) return;

    // UserService()
    //     .setupUser(_usernameController.text, _clubController.text)
    //     .then((_) => context.go('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create a new user',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24.0),
            // Username input
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              controller: _usernameController,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) => _usernameController.text = value.trim(),
            ),
            const SizedBox(height: 24.0),
            // Club input
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Club',
              ),
              controller: _clubController,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => _clubController.text = value.trim(),
            ),
            const SizedBox(height: 32.0),
            OutlinedButton(
              onPressed: () => submitUser(context),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Submit'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

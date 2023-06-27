import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  PasswordScreen({super.key});

  void submit(BuildContext context) {
    final AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);

    // If input is not valid, then do nothing
    if (_passwordController.text == "") return;

    authenticationService
        .setPassword(
      context: context,
      password: _passwordController.text,
    )
        .then(
      (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isSuccess ? 'Success' : 'Failure',
            ),
          ),
        );
        if (!isSuccess) return;

        context.go('/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nouveau mot de passe',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24.0),
            StatefulBuilder(builder: (context, StateSetter setState) {
              return TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Mot de passe',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => obscureText = !obscureText);
                    },
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: obscureText,
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) => _passwordController.text = value.trim(),
              );
            }),
            const SizedBox(height: 32.0),
            OutlinedButton(
              onPressed: () => submit(context),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Confirmer'.toUpperCase(),
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

import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/application/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  bool isInputValid(String username) {
    return username != "" && _passwordController.text != "";
  }

  void submitUser(BuildContext context, String username) {
    final AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);

    // If input is not valid, then do nothing
    if (!isInputValid(username)) return;

    authenticationService
        .login(
          username: username,
          password: _passwordController.text,
        )
        .then((value) => context.go('/'));
  }

  @override
  Widget build(BuildContext context) {
    String selectedUsername = '';
    AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: true);
    if (authenticationService.status == AuthenticationStatus.authenticated) {
      // context.push('/');
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 24.0),
        child: FutureBuilder(
            future: UserService().getNameList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: Transform.scale(
                    scale: 1.5,
                    child: const CircularProgressIndicator(),
                  ),
                );
              }

              final List<String> usernameList = snapshot.data;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Connexion',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 24.0),
                  // Username input
                  Autocomplete(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return List<String>.empty();
                      }
                      return usernameList.where(
                        (username) => username
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()),
                      );
                    },
                    fieldViewBuilder: (
                      BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted,
                    ) {
                      return TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nom',
                        ),
                        controller: textEditingController,
                        focusNode: focusNode,
                        onFieldSubmitted: (String value) => onFieldSubmitted(),
                        textInputAction: TextInputAction.next,
                      );
                    },
                    onSelected: (String value) => selectedUsername = value,
                  ),
                  const SizedBox(height: 24.0),
                  // Club input
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mot de passe',
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) =>
                        _passwordController.text = value.trim(),
                  ),
                  const SizedBox(height: 32.0),
                  OutlinedButton(
                    onPressed: () => submitUser(context, selectedUsername),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Confirmer'.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

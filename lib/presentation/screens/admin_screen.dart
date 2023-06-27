import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/application/user_service.dart';
import 'package:fencing_tracker/domain/user.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  User? selectedUser;

  void registerUser(
    AuthenticationService authenticationService,
    TextEditingController controller,
  ) {
    authenticationService.register(username: controller.text).then(
      (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isSuccess ? 'Success' : 'Failure',
            ),
          ),
        );
        controller.clear();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);

    return FutureBuilder(
        future: UserService().getUsers(
          context: context,
          includeCurrentUser: true,
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Transform.scale(
                scale: 1.5,
                child: const CircularProgressIndicator(),
              ),
            );
          }
          final List<User> userList = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                'Ajouter nouvel utilisateur:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8.0),
              Autocomplete<User>(
                initialValue:
                    TextEditingValue(text: selectedUser?.username ?? ''),
                displayStringForOption: (user) => user.username,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<User>.empty();
                  }
                  return userList.where(
                    (user) => user.username
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
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Utilisateur',
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => textEditingController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                            IconButton(
                              onPressed: () => registerUser(
                                authenticationService,
                                textEditingController,
                              ),
                              icon: const Icon(Icons.done),
                            ),
                            const SizedBox(width: 4.0),
                          ],
                        )),
                    controller: textEditingController,
                    focusNode: focusNode,
                    onFieldSubmitted: (String value) => onFieldSubmitted(),
                    textInputAction: TextInputAction.next,
                  );
                },
                onSelected: (user) => setState(() {
                  selectedUser = user;
                }),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Code: ${selectedUser?.code ?? 'N/A'}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          );
        });
  }
}

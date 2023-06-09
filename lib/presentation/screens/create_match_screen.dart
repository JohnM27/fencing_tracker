import 'package:fencing_tracker/domain/user.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateMatchScreen extends StatefulWidget {
  const CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  User? selectedUser;
  int nbTouches = 5;
  // final TextEditingController givenTouchesController = TextEditingController();
  int givenTouches = 0;
  int receivedTouches = 0;
  bool? isVictory;

  void updateIsVictory() {
    if (givenTouches == receivedTouches) {
      isVictory = null;
      return;
    }
    isVictory = givenTouches > receivedTouches;
  }

  Color getResultColor() {
    if (isVictory == null) {
      return CustomColors.white;
    }
    return isVictory! ? CustomColors.green : CustomColors.red;
  }

  String getResultMsg() {
    if (isVictory == null) {
      return 'Résultat ?';
    }
    return isVictory! ? 'Victoire' : 'Défaite';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        // if (snapshot.connectionState != ConnectionState.done) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        List<User> userList = [
          const User(id: 1, username: "Jean-Marc Diot", clubId: 1),
          const User(id: 2, username: "Olivier Jeandel", clubId: 1),
          const User(id: 3, username: "Lilie Chatton", clubId: 1),
        ]; //snapshot.data;
        // List<Map<String, dynamic>> nbTouches = [
        //   {'label': '5 touches', 'value': 5}
        // ];

        return Column(
          children: [
            Text(
              'Nouveau match',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24.0),
            // Username input
            Autocomplete<User>(
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adversaire',
                  ),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) => onFieldSubmitted(),
                  textInputAction: TextInputAction.next,
                );
              },
              onSelected: (user) => selectedUser = user,
            ),
            const SizedBox(height: 24.0),
            Wrap(
              spacing: 8.0,
              children: [
                ChoiceChip(
                  label: const Text('5 Touches'),
                  selected: nbTouches == 5,
                  onSelected: (_) {
                    setState(() => nbTouches = 5);
                  },
                ),
                ChoiceChip(
                  label: const Text('15 Touches'),
                  selected: nbTouches == 15,
                  onSelected: (_) {
                    setState(() => nbTouches = 15);
                  },
                ),
                // TODO: custom nb touches
                // ChoiceChip(
                //   label: const Text('Autre'),
                //   selected: nbTouches == 0,
                //   onSelected: (_) {
                //     setState(() => nbTouches = 0);
                //   },
                // ),
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // const Text('Touches données:'),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            givenTouches = nbTouches;
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'MAX',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            if (givenTouches < nbTouches) {
                              givenTouches++;
                            }
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '+1',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '$givenTouches',
                        style: GoogleFonts.orbitron(fontSize: 64.0),
                        // style: const TextStyle(fontSize: 64.0),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            if (givenTouches > 0) {
                              givenTouches--;
                            }
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '-1',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            givenTouches = 0;
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'MIN',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'TD - TR',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            receivedTouches = nbTouches;
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'MAX',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            if (receivedTouches < nbTouches) {
                              receivedTouches++;
                            }
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '+1',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '$receivedTouches',
                        style: GoogleFonts.orbitron(fontSize: 64.0),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            if (receivedTouches > 0) {
                              receivedTouches--;
                            }
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '-1',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => setState(() {
                            receivedTouches = 0;
                            updateIsVictory();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'MIN',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: getResultColor()),
                borderRadius: BorderRadius.circular(50.0),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                getResultMsg(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: getResultColor()),
              ),
            ),
            // const SizedBox(height: 24.0),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => print('confirm'),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Confirmer'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:fencing_tracker/application/match_service.dart';
import 'package:fencing_tracker/application/user_service.dart';
import 'package:fencing_tracker/domain/user.dart';
import 'package:fencing_tracker/presentation/dialog/select_victory_dialog.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateMatchScreen extends StatefulWidget {
  const CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  List<User> userList = List.empty();
  User? selectedUser;
  int nbTouches = 5;
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

  bool validateInput() {
    return selectedUser != null && isVictory != null;
  }

  void submit() {
    MatchService()
        .createMatch(
      context: context,
      nbTouches: nbTouches,
      opponentId: selectedUser!.id,
      givenTouches: givenTouches,
      receivedTouches: receivedTouches,
      isWin: isVictory!,
    )
        .then((isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isSuccess ? 'Success' : 'Failure',
          ),
        ),
      );
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: userList.isEmpty
              ? UserService().getUsers(context: context)
              : null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done &&
                userList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            userList = snapshot.data;
            return Column(
              children: [
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
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: receivedTouches == nbTouches &&
                                      givenTouches == nbTouches - 1
                                  ? null
                                  : () => setState(() {
                                        if (receivedTouches == nbTouches) {
                                          givenTouches = nbTouches - 1;
                                          updateIsVictory();
                                          return;
                                        }
                                        givenTouches = nbTouches;
                                        updateIsVictory();
                                      }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                              onPressed: receivedTouches == nbTouches &&
                                      givenTouches == nbTouches - 1
                                  ? null
                                  : () => setState(() {
                                        if (givenTouches < nbTouches) {
                                          givenTouches++;
                                        }
                                        updateIsVictory();
                                      }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                              onPressed: givenTouches == nbTouches &&
                                      receivedTouches == nbTouches - 1
                                  ? null
                                  : () => setState(() {
                                        if (givenTouches == nbTouches) {
                                          receivedTouches = nbTouches - 1;
                                          updateIsVictory();
                                          return;
                                        }
                                        receivedTouches = nbTouches;
                                        updateIsVictory();
                                      }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                              onPressed: givenTouches == nbTouches &&
                                      receivedTouches == nbTouches - 1
                                  ? null
                                  : () => setState(() {
                                        if (receivedTouches < nbTouches) {
                                          receivedTouches++;
                                        }
                                        updateIsVictory();
                                      }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: getResultColor()),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: givenTouches == receivedTouches
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const SelectVictoryDialog(),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    isVictory = value as bool;
                                  });
                                }
                              });
                            }
                          : null,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Padding(
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
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: validateInput() ? () => submit() : null,
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

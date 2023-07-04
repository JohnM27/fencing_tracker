import 'package:fencing_tracker/application/user_service.dart';
import 'package:fencing_tracker/domain/user.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryPeople extends StatelessWidget {
  const HistoryPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getUsers(context: context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        List<User> opponents = snapshot.data;
        opponents.sort((a, b) => a.username.compareTo(b.username));

        return ListView(
          padding: const EdgeInsets.all(24.0),
          children: List.generate(opponents.length, (index) {
            User opponent = opponents[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == opponents.length - 1 ? 0.0 : 12.0,
              ),
              child: ListTile(
                title: Text(opponent.username),
                trailing: const Icon(Icons.arrow_forward_ios),
                tileColor: CustomColors.purple.withOpacity(0.25),
                onTap: () => context.go(
                  '/history/opponent',
                  extra: opponent,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

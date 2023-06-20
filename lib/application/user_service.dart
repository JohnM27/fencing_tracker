import 'package:fencing_tracker/data/user_repository.dart';
import 'package:fencing_tracker/domain/user.dart';
import 'package:flutter/material.dart';

class UserService {
  final UserRepository userRepository = UserRepository();

  Future<List<String>> getNameList() async {
    List<dynamic> usernames = await userRepository.getNameList();
    return usernames.map((e) => e.toString()).toList();
  }

  Future<List<User>> getUsers({
    required BuildContext context,
    bool includeCurrentUser = false,
  }) async {
    try {
      List<dynamic> users = await userRepository.getUsers(
        context: context,
        includeCurrentUser: includeCurrentUser,
      );
      return users.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return List.empty();
    }
  }
}

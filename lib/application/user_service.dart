import 'package:fencing_tracker/application/club_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final UserService _instance = UserService._();

  late String username;
  late bool userExist;

  UserService._();
  factory UserService() => _instance;

  init() async {
    var user = await getUserFromSharedPrefs();
    userExist = user != null;
    if (user != null) {
      username = user;
    }
  }

  Future<void> setupUser(String username, String club) async {
    await setUserInSharedPrefs(username);
    await ClubService().createClub(club);

    userExist = true;
  }

  Future<void> setUserInSharedPrefs(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);

    username = username;
  }

  Future<String?> getUserFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}

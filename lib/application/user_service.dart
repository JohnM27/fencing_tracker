import 'package:fencing_tracker/data/user_repository.dart';

class UserService {
  final UserRepository userRepository = UserRepository();

  Future<List<String>> getNameList() async {
    List<dynamic> usernames = await userRepository.getNameList();
    return usernames.map((e) => e.toString()).toList();
  }

  // static final UserService _instance = UserService._();

  // late String username;
  // late bool userExist;

  // UserService._();
  // factory UserService() => _instance;

  // init() async {
  //   var user = await getUserFromSharedPrefs();
  //   userExist = user != null;
  //   if (user != null) {
  //     username = user;
  //   }
  // }

  // Future<void> setupUser(String username, String club) async {
  //   await setUserInSharedPrefs(username);
  //   // await ClubService().createClub(club);

  //   userExist = true;
  // }

  // Future<void> setUserInSharedPrefs(String username) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('username', username);

  //   username = username;
  // }

  // Future<String?> getUserFromSharedPrefs() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('username');
  // }
}

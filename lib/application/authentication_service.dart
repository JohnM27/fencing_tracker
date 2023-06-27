import 'package:fencing_tracker/data/authentication_repository.dart';
import 'package:fencing_tracker/domain/user.dart';
import 'package:fencing_tracker/utils/exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationService extends ChangeNotifier {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  late User _user;
  late String _accessToken;
  bool _userHasPassword = true;
  AuthenticationStatus _status = AuthenticationStatus.unauthenticated;
  bool _tryRefresh = false;

  AuthenticationService();

  factory AuthenticationService.fromProvider(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<AuthenticationService>(context, listen: listen);
  }

  User get user => _user;

  String get accessToken => _accessToken;

  AuthenticationStatus get status => _status;

  bool get tryRefresh => _tryRefresh;

  bool get userHasPassword => _userHasPassword;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> json = await authenticationRepository.login(
      username: username,
      password: password,
    );
    _accessToken = json['access_token'];
    _userHasPassword = json['has_password'];
    _user = User.fromJson(json['user']);
    _status = AuthenticationStatus.authenticated;
    notifyListeners();
  }

  Future<void> refresh() async {
    _tryRefresh = true;
    try {
      Map<String, dynamic> json = await authenticationRepository.refresh();
      _accessToken = json['access_token'];
      _user = User.fromJson(json['user']);
      _status = AuthenticationStatus.authenticated;
      notifyListeners();
    } on LoginFailure {
      debugPrint('LoginFailure');
    }
  }

  Future<bool> register({
    required String username,
  }) async {
    try {
      await authenticationRepository.register(username: username);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> setPassword({
    required BuildContext context,
    required String password,
  }) async {
    try {
      await authenticationRepository.setPassword(
          context: context, password: password);
      _userHasPassword = true;
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

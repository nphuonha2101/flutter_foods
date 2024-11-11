import 'dart:convert';

import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final AuthRepository _authRepositories;

  const AuthService(this._authRepositories);

  Future<bool> login(String email, String password) async {
    try {
      AuthCredential authCredential =
          await _authRepositories.login(email, password);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('credential', jsonEncode(authCredential.toJson()));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> register(String email, String password) async {
    return true;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('credential');
  }
}

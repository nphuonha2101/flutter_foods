import 'dart:convert';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final AuthRepository _authRepository;

  // Constructor accepts an AuthRepository instance
  const AuthService(this._authRepository);

  Future<bool> login(String username, String password) async {
    try {
      AuthCredential authCredential =
          await _authRepository.login(username, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('credential', jsonEncode(authCredential.toJson()));
      return true;
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }

  Future<bool> register(String name, String email, String password,
      String username, String phone, String address) async {
    try {
      return await _authRepository.register(
          name, email, password, username, phone, address);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('credential');
    await _authRepository.logout(token);
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('credential');
  }

  Future<AuthCredential?> getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? credentialJson = prefs.getString('credential');
    if (credentialJson != null) {
      return AuthCredential.fromJson(jsonDecode(credentialJson));
    }
    return null;
  }

  Future<Map<String, dynamic>> sendOtp(String email) async {
    return await _authRepository.sendOtp(email);
  }

  Future<void> changePassword(String newPassword, String otp) async {
    try {
      await _authRepository.changePassword(newPassword, otp);
    } catch (e) {
      rethrow;
    }
  }
}

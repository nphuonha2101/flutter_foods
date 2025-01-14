import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  bool _isAuthenticated = false;
  bool _isLoading = false; // For handling loading states.
  String _errorMessage = '';
  AuthCredential? _authCredential;

  AuthProvider(this._authService);

  // Getters
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  AuthCredential? get authCredential => _authCredential;

  // Login method
  Future<void> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _isAuthenticated = await _authService.login(username, password);
      if (_isAuthenticated) {
        _authCredential = await _authService.getCredentials();
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Initialize method to check if the user is already logged in
  Future<void> initialize() async {
    _isLoading = true;
    // notifyListeners();

    try {
      _isAuthenticated = await _authService.isLoggedIn();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout method
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    final credential = prefs.getString('credential');
    if (credential != null) {
      AppLogger.debug('Logging out with credential: $credential');
      final token = AuthCredential.fromJson(jsonDecode(credential)).token;
      await _authService.logout(token);
      _isAuthenticated = false;
      notifyListeners();
    } else {
      throw Exception('No credential found');
    }
  }

  Future<Map<String, dynamic>> sendOtp(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.sendOtp(email);

      return response;
    } catch (e) {
      _errorMessage = e.toString();

      return {
        'status': false,
        'message': _errorMessage,
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changePassword(String newPassword, String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.changePassword(newPassword, otp);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String email, String password,
      String username, String phone, String address) async {
    try {
      return await _authService.register(
          name, email, password, username, phone, address);
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}

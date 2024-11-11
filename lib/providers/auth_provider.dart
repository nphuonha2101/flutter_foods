import 'package:flutter/material.dart';
import 'package:flutter_foods/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  bool _isAuthenticated = false;
  String _errorMessage = '';

  // Getters
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    try {
      _isAuthenticated = await _authService.login(username, password);
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  void logout() {
    _authService.logout();
    _isAuthenticated = false;

    notifyListeners();
  }
}

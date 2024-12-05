import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);
  
  bool _isAuthenticated = false;
  String _errorMessage = '';
  AuthCredential? _authCredential ;
  // Getters
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;
  AuthCredential? get authCredential => _authCredential;
  Future<void> login(String username, String password) async {
    try {
      _isAuthenticated = await _authService.login(username, password);
      if (_isAuthenticated) {
        _authCredential = await _authService.getCredentials();
      }
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

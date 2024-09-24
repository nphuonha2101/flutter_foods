import 'package:flutter/material.dart';
import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/services/user_service.dart';

class UsersProvider with ChangeNotifier {
  final UserService _userService;
  List<User> _users = [];
  bool _isLoading = false;
  bool _hasError = false;

  UsersProvider(this._userService);

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchAll() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _users = await _userService.fetchAll();
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> create(UserDto dto) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _userService.create(dto);
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> update(UserDto dto, num id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _userService.update(dto, id);
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> delete(num id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _userService.delete(id);
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _users = [];
    _isLoading = false;
    _hasError = false;
    notifyListeners();
  }
}

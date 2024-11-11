import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<List<User>> fetchAll() async {
    try {
      return _userRepository.fetchAll();
    } catch (e) {
      throw Exception('Failed to load users. Error: $e');
    }
  }

  Future<User> fetch(num id) async {
    try {
      return _userRepository.fetch(id);
    } catch (e) {
      throw Exception('Failed to load user. Error: $e');
    }
  }

  Future<User> create(UserDto user) async {
    try {
      return _userRepository.create(user);
    } catch (e) {
      throw Exception('Failed to create user. Error: $e');
    }
  }

  Future<User> update(UserDto user, num id) async {
    try {
      return _userRepository.update(user, id);
    } catch (e) {
      throw Exception('Failed to update user. Error: $e');
    }
  }

  Future<void> delete(num id) async {
    try {
      return _userRepository.delete(id);
    } catch (e) {
      throw Exception('Failed to delete user. Error: $e');
    }
  }
}

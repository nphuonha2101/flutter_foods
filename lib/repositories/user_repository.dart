import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';

class UserRepository with AbstractApiRepositories<User, UserDto> {
  @override
  User createModel() {
    return User(
      id: 0,
      name: '',
      email: '',
      phone: '',
      address: '',
      password: '',
      avatarUrl: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

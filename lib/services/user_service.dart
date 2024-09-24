import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/services/abstract_api_service.dart';

class UserService with ApiService<User, UserDto> {
  @override
  User createModel() {
    return User(
      id: 0,
      name: '',
      email: '',
      password: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

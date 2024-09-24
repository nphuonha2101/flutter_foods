import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class User extends IModel {
  final num id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.createdAt,
      required this.updatedAt});

  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as num,
      name: json['name'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  UserDto toDto() {
    return UserDto(
      name: name,
      email: email,
      password: password,
    );
  }
}

import 'package:flutter_foods/data/dtos/i_dto.dart';

class UserDto extends IDto {
  String name;
  String email;
  String password;

  UserDto({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}

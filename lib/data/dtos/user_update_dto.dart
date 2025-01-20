import 'package:flutter_foods/data/dtos/i_dto.dart';

class UserUpdateDto extends IDto {
  String email;
  String name;
String phone;
String avatar;
  UserUpdateDto({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
    };
  }

  factory UserUpdateDto.fromJson(Map<String, dynamic> json) {
    return UserUpdateDto(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }
}

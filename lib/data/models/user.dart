import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class User extends IModel {
  final num id;
  late String name;
  late String email;
  late String phone;
  late String address;
  late String avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.avatarUrl,
      required this.createdAt,
      required this.updatedAt});

  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as num,
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      avatarUrl: json['avatarUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  UserDto toDto() {
    return UserDto(name: name, email: email);
  }
}

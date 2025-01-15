import 'dart:convert';
import 'dart:io';

import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';
import 'package:http/http.dart' as http;

class UserRepository with AbstractApiRepositories<User, UserDto> {
final String apiUrl = ApiConstants.apiUrl.toString();
  
  @override
  User createModel() {
    return User(
      id: 0,
      name: '',
      email: '',
      phone: '',
      address: '',
      avatarUrl: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<User> fetchByEmail(String email) async {
    final response = await http.get(
      Uri.parse('$baseApiUrl/user?email=$email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return createModel().fromJson(json.decode(response.body));
    } else {
      throw Exception('fetch all: ${response.statusCode}');
    }
  }

Future<bool> updateUser(String email, String name, String phone, String avatar) async {
  try {
    var uri = Uri.parse('$baseApiUrl/user/update');
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });
    request.fields['email'] = email;
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['avatar'] = avatar;
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Update user failed: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating user: $e');
    return false;
  }
}
}

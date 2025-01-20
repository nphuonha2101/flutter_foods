import 'dart:convert';
import 'dart:io';

import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/data/dtos/user_dto.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

  Future<User> fetchById(int id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    
    print("Resp:" + response.body);
    if (response.statusCode == 200) {
      return createModel().fromJson(json.decode(response.body));
    } else {
      throw Exception('fetch all: ${response.statusCode}');
    }
  }



  Future<bool> updateUser(
      String email, String name, String phone, XFile? avatar) async {
    try {
      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/user/update'),
      );

      // Add headers
      request.headers.addAll({
        'Accept': 'application/json',
      });

      // Add text fields
      request.fields['email'] = email;
      request.fields['username'] = name;
      request.fields['phone'] = phone;

      // Add avatar file if exists
      if (avatar != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar',
            avatar.path,
            filename: avatar.name,
          ),
        );
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Resp: "+ response.toString());

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

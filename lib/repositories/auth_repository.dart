import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final String baseUrl = ApiConstants.baseUrl;
  final String version = ApiConstants.version.toString();
  final String port = ApiConstants.port.toString();

  Future<AuthCredential> login(String username, String password) async {
    return http
        .post(
      Uri.parse('$baseUrl:$port/api/$version/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    )
        .then((response) {
      if (response.statusCode == 200) {
        String body = response.body;
        String token = json.decode(body)['token'];
        String username = json.decode(body)['username'];
        String userFullName = json.decode(body)['userFullName'];
        String userEmail = json.decode(body)['userEmail'];

        return AuthCredential(
          token: token,
          username: username,
          userFullName: userFullName,
          userEmail: userEmail,
        );
      } else {
        String error = json.decode(response.body);
        throw Exception(error);
      }
    });
  }
}

import 'dart:convert';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class AuthRepository {
  final String baseUrl = ApiConstants.baseUrl;
  final String version = ApiConstants.version.toString();
  final String port = ApiConstants.port.toString();

  // Login function that communicates with the API
  Future<AuthCredential> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/api/user/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': username, 'password': password}),
      );
        var jsonResponse = json.decode(response.body);

      if (jsonResponse['statusCode'] == 200) {
        return AuthCredential.fromJson(jsonResponse['data']);
      } else {
        String error = json.decode(response.body)['message'] ?? 'Unknown error';
        throw Exception(error);
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}

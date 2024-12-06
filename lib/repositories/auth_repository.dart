import 'dart:convert';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class AuthRepository {
  final String baseUrl = ApiConstants.baseUrl;
  final String version = ApiConstants.version.toString();
  final String port = ApiConstants.port.toString();

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

    Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/api/user/auth/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var jsonResponse = json.decode(response.body);

      if (jsonResponse['statusCode'] != 200) {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
    Future<Map<String, dynamic>> sendOtp(String email) async {
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/api/user/password/otp-mail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'email': email}),
    );

    var jsonResponse = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonResponse['message'] ?? 'Failed to send OTP');
    }

    return jsonResponse; // Trả về JSON nếu thành công
  } catch (e) {
    return {
      'status': false,
      'message': 'Failed to send OTP: $e',
    };
  }
}


  // Change password with OTP verification
 Future<Map<String, dynamic>> changePassword(String newPassword, String otp) async {
  try {
    final requestBody = {
      'password': newPassword,
      'code': otp,
    };
    // Gửi yêu cầu POST
    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/api/user/password/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(requestBody),
    );
    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['statusCode'] == 200) {
      return {
        'status': true,
        'message': jsonResponse['message'] ?? 'Password changed successfully',
      };
    } else {
      return {
        'status': false,
        'message': jsonResponse['message'] ?? 'Failed to change password',
      };
    }
  } catch (e) {
    return {
      'status': false,
      'message': 'Failed to change password: $e',
    };
  }
}

  
}

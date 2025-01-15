import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordProfileScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ChangePasswordProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _loadEmailFromSharedPreferences();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Đổi Mật Khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Đổi mật khẩu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ấn để lấy mã xác thực.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Địa chỉ Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          final email = _emailController.text.trim();
                          if (email.isEmpty) {
                            _showSnackbar(context, 'Vui lòng nhập địa chỉ email hợp lệ');
                            return;
                          }

                          await _handleSendOtp(context, provider, email);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: provider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Gửi OTP',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Quay lại',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
Future<AuthCredential?> getCredentialFromSharedPreferences() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? credentialJson = prefs.getString('credential');
    if (credentialJson != null) {
      Map<String, dynamic> credentialMap = jsonDecode(credentialJson);
      return AuthCredential.fromJson(credentialMap);
    }
    return null; // Không tìm thấy thông tin
  } catch (e) {
    print('Error getting credential: $e');
    return null;
  }
}
  Future<void> _loadEmailFromSharedPreferences() async {
    AuthCredential? credential = await getCredentialFromSharedPreferences();
  if (credential != null) {
    String? email = credential.userEmail;
  _emailController.text = email;
  }
}
  /// Hàm xử lý phản hồi từ API
  Future<void> _handleSendOtp(BuildContext context, AuthProvider provider, String email) async {
    final response = await provider.sendOtp(email);

    if (response['status'] == true) {
      _showSnackbar(context, 'OTP đã được gửi!');
      Navigator.pushNamed(context, AppRoutes.changePassword);
    } else {
      final errorMessage = response['message'] ?? 'Đã xảy ra lỗi. Vui lòng thử lại!';
      _showSnackbar(context, errorMessage);
    }
  }

  /// Hàm hiển thị SnackBar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

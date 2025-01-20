import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user; // User fetched từ API
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  AuthCredential? credential;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _editingField;

  @override
  void initState() {
    super.initState();
    _loadUserFromCredential();
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

  Future<void> _loadUserFromCredential() async {
    credential = await getCredentialFromSharedPreferences();
    if (credential != null) {
      setState(() {
        user = User(
          id: credential!.id,
          name: credential!.username,
          email: credential!.userEmail,
          phone: credential!.userPhone,
          address: credential!.userAddress,
          avatarUrl: credential!.avatar,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        _nameController.text = credential!.username;
        _emailController.text = credential!.userEmail;
        _phoneController.text = credential!.userPhone;
        _addressController.text = "Chọn địa chỉ";
        _passwordController.text = "Ấn để đổi mật khẩu";
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
      if (_image != null && user != null) {
        user!.avatarUrl = _image!.path;
      }
    });

    Provider.of<UsersProvider>(context, listen: false)
        .updateUser(user!.email, user!.name, user!.phone, _image);

    print(user!.avatarUrl);
    print(user!.name);
    print(user!.phone);
  }

  void _toggleEditMode(String field, TextEditingController controller,
      void Function(String) onSave) async {
    if (field == 'address') {
      await Navigator.pushNamed(context, '/choose-address');
    } else if (field == 'password') {
      await Navigator.pushNamed(context, '/change-password-profile');
    } else {
      if (_editingField == field) {
        onSave(controller.text); 

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? credentialJson = prefs.getString('credential');
        AuthCredential authCredential =
            AuthCredential.fromJson(jsonDecode(credentialJson!));

            authCredential.username = user!.name;
            authCredential.userPhone = user!.phone;
            authCredential.avatar = user!.avatarUrl;

        prefs.setString("credential", jsonEncode(authCredential.toJson()));
        setState(() {
          _editingField = ''; 
        });

        await Provider.of<UsersProvider>(context, listen: false)
            .updateUser(user!.email, user!.name, user!.phone, _image);

        print(user!.avatarUrl);
        print(user!.name);
        print(user!.phone);
      } else {
        setState(() {
          _editingField = field; 
        });
      }
    }
  }

  Widget _buildEditableRow({
    required String label,
    required String field,
    required TextEditingController controller,
    required void Function(String) onSave,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              enabled: _editingField == field &&
                  field != 'address' &&
                  field != 'password' &&
                  field != 'email',
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (field != 'email')
            IconButton(
              icon: Icon(
                (field == 'address' || field == 'password')
                    ? Icons.arrow_forward
                    : (_editingField == field ? Icons.check : Icons.edit),
                color: (field == 'address' || field == 'password')
                    ? Colors.blue
                    : (_editingField == field ? Colors.green : Colors.blue),
              ),
              onPressed: () => _toggleEditMode(field, controller, onSave),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        appBar: AppBar(
          title: const Text('Trang cá nhân'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: const Text('Đăng nhập'),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBar(
        title: const Text('Trang cá nhân'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!.path))
                          : NetworkImage(user!.avatarUrl) as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user!.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildEditableRow(
              label: 'Tên:',
              field: 'name',
              controller: _nameController,
              onSave: (value) => user!.name = value,
            ),
            _buildEditableRow(
              label: 'Email:',
              field: 'email',
              controller: _emailController,
              onSave: (value) => user!.email = value,
            ),
            _buildEditableRow(
              label: 'Số điện thoại:',
              field: 'phone',
              controller: _phoneController,
              onSave: (value) => user!.phone = value,
            ),
            _buildEditableRow(
              label: 'Địa chỉ',
              field: 'address',
              controller: _addressController,
              onSave: (value) => user!.address = "Chọn địa chỉ",
            ),
            _buildEditableRow(
              label: 'Đổi mật khẩu',
              field: 'password',
              controller: _passwordController,
              onSave: (value) => user!.address = "Ấn để đổi mật khẩu",
            ),
          ],
        ),
      ),
    );
  }
}

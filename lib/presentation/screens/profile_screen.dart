import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user = User(
    id: 1,
    name: 'Nokotan',
    email: 'Nokotan@example.com',
    phone: '0987654321',
    address: 'abc street, xyz city',
    password: '',
    avatarUrl: 'https://images8.alphacoders.com/136/1368855.png',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _editingField;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;


  @override
  void initState() {
    super.initState();
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _addressController.text = user.address;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleEditMode(String field, TextEditingController controller, void Function(String) onSave) {
  setState(() {
    if (field == 'address') {
      Navigator.pushNamed(context, '/choose-address');
    } else {
      if (_editingField == field) {
        onSave(controller.text);
        _editingField = '';
      } else {
        _editingField = field;
      }
    }
  });
}

Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
      if (_image != null) {
        user.avatarUrl = _image!.path;
      }
    });
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
            offset: Offset(0, 3),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              enabled: _editingField == field && field != 'address',
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(
              field == 'address' ? Icons.arrow_forward : (_editingField == field ? Icons.check : Icons.edit),
              color: field == 'address' ? Colors.blue : (_editingField == field ? Colors.green : Colors.blue),
            ),
            onPressed: () => _toggleEditMode(field, controller, onSave),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          : NetworkImage(user.avatarUrl) as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildEditableRow(
              label: 'Tên:',
              field: 'name',
              controller: _nameController,
              onSave: (value) => user.name = value,
            ),
            _buildEditableRow(
              label: 'Email:',
              field: 'email',
              controller: _emailController,
              onSave: (value) => user.email = value,
            ),
            _buildEditableRow(
              label: 'Phone:',
              field: 'phone',
              controller: _phoneController,
              onSave: (value) => user.phone = value,
            ),
            _buildEditableRow(
              label: 'Address:',
              field: 'address',
              controller: _addressController,
              onSave: (value) => user.address = value,
            ),
          ],
        ),
      ),
    );
  }
}

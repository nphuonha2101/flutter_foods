import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user = User(
    id: 1,
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '0987654321',
    address: 'abc street, xyz city',
    password: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _editingField;

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
      if (_editingField == field) {
        onSave(controller.text);
        _editingField = null; // Exit edit mode
      } else {
        _editingField ??= field;
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
      color: Colors.white, // White background for editable rows
      margin: const EdgeInsets.only(bottom: 4.0), // Bottom margin only for line effect
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Optional padding inside row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              enabled: _editingField == field,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _editingField == field ? Icons.check : Icons.edit,
              color: _editingField == field ? Colors.green : Colors.blue,
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
      backgroundColor: Colors.grey.shade200, // Light gray background for the page
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    );
  }
}

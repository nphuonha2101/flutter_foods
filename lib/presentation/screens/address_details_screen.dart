import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/screens/handle_address_screen.dart';

class AddressDetailsScreen extends StatefulWidget {
  final String type;
  final String name;
  final String phone;
  final String address;
  final bool isDefault;

  const AddressDetailsScreen({
    super.key,
    required this.type,
    required this.name,
    required this.phone,
    required this.address,
    required this.isDefault,
  });

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late bool isDefault = false;

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    addressController = TextEditingController(text: widget.address);
    isDefault = widget.isDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.type == "add" ? "Thêm" : "Sửa"} địa chỉ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Họ và tên",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Số điện thoại",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Địa chỉ",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final pickedData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HandleAddressScreen(),
                      ),
                    );

                    if (pickedData != null &&
                        pickedData is Map<String, dynamic>) {
                      setState(() {
                        addressController.text = pickedData["address"];
                        latitude = pickedData["latitude"];
                        longitude = pickedData["longitude"];
                      });
                    }
                  },
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Đặt làm địa chỉ mặc định",
                  style: TextStyle(fontSize: 16.0),
                ),
                Switch(
                  value: isDefault,
                  onChanged: (value) {
                    setState(() {
                      isDefault = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // xu ly them vao db
                },
                child: const Text("Lưu"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

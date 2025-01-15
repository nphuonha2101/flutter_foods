import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/dtos/address_dto.dart';
import 'package:flutter_foods/presentation/screens/choose_address_screen.dart';
import 'package:flutter_foods/presentation/screens/handle_address_screen.dart';
import 'package:flutter_foods/providers/address_provider.dart';
import 'package:provider/provider.dart';

class AddressDetailsScreen extends StatefulWidget {
  final int id;
  final String type;
  final String name;
  final String phone;
  final String address;
  final String longitude;
  final String latitude;
  final bool isDefault;
  final int userId;

  const AddressDetailsScreen({
    super.key,
    required this.id,
    required this.type,
    required this.name,
    required this.phone,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.isDefault,
    required this.userId,
  });

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  late int id;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late String longitude;
  late String latitude;
  late bool isDefault = false;
  late int userId;

  @override
  void initState() {
    super.initState();

    id = widget.id;
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    addressController = TextEditingController(text: widget.address);
    longitude = widget.longitude;
    latitude = widget.latitude;
    isDefault = widget.isDefault;
    userId = widget.userId;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final addressProvider =
                          Provider.of<AddressProvider>(context, listen: false);

                      final addressData = AddressDto(
                        name: nameController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        longitude: longitude.toString().isEmpty
                            ? "0"
                            : longitude.toString(),
                        latitude: latitude.toString().isEmpty
                            ? "0"
                            : latitude.toString(),
                        isDefault: isDefault ? 1 : 0,
                        userId: userId,
                      );

                      if (widget.type == "add") {
                        await addressProvider.create(addressData);
                      } else {
                        await addressProvider.update(addressData, id);
                      }

                      Navigator.pop(context, "success");
                      Navigator.pop(context, "success");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseAddressScreen(),
                        ),
                      );
                    },
                    child: const Text("Lưu"),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.type != "add") {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Xác nhận"),
                              content: const Text(
                                  "Bạn có chắc chắn muốn xóa địa chỉ này không?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("Hủy"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("Xóa"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          final addressProvider = Provider.of<AddressProvider>(
                              context,
                              listen: false);
                          await addressProvider.delete(id);
                          Navigator.pop(context, "deleted");
                          Navigator.pop(context, "deleted");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChooseAddressScreen(),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("Xóa"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

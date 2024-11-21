import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/address.dart';
import 'package:flutter_foods/presentation/screens/address_details_screen.dart';
import 'package:flutter_foods/presentation/screens/handle_address_screen.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({super.key});

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  final List<Address> addresses = [
    Address(
      id: 1,
      name: "Nguyễn Tấn Khoa",
      phone: "(+84) 938 700 000",
      address:
          "99, đường 999, Phường Tăng Nhơn Phú A, Thành Phố Thủ Đức, TP. Hồ Chí Minh",
      isDefault: true,
    ),
    Address(
      id: 2,
      name: "Phan Văn ABC",
      phone: "(+84) 903 333 333",
      address:
          "33 đường 333, Phường Tăng Nhơn Phú A, Thành Phố Thủ Đức, TP. Hồ Chí Minh",
    ),
  ];

  int selectedAddressIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chọn địa chỉ nhận hàng"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Radio<int>(
                      value: index,
                      groupValue: selectedAddressIndex,
                      onChanged: (value) {
                        setState(() {
                          selectedAddressIndex = value!;
                        });
                      },
                    ),
                    title: Text(
                      address.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address.phone),
                        Text(address.address),
                        if (address.isDefault)
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 91, 79),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Mặc định",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.addressDetail, arguments: {
                          'type': 'edit',
                          'name': address.name,
                          'phone': address.phone,
                          'address': address.address,
                          'isDefault': address.isDefault,
                        });
                      },
                      child: const Text(
                        "Sửa",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.black),
            title: const Text(
              "Thêm Địa Chỉ Mới",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.addressDetail, arguments: {
                'type': 'add',
                'name': '',
                'phone': '',
                'address': '',
                'isDefault': false,
              });
            },
          ),
        ],
      ),
    );
  }
}

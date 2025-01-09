import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/payment_method.dart';
import 'package:flutter_foods/data/models/address.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/shop.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/presentation/widgets/order_screen_bottom_app_bar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _paymentMethod = -1;
  String note = '';

  final List<CartItem> items = [
    CartItem(
      food: Food(
        id: 1,
        name: 'Bún chả',
        price: 50000,
        imageUrl: 'https://bing.com/th?id=OSK.6a5f75c9e4f2cbbbe916a6aa19763a35',
        category: 'Món chính',
          description: 'Bún chả',
        rating: 4.5,
        reviewCount: 100,
        shopId: 1,
         shopName: "aa",
        distance: 2.2,
      ),
      quantity: 2,
    ),
    CartItem(
      food: Food(
        id: 2,
        name: 'Bún riêu',
        price: 40000,
        imageUrl: 'https://bing.com/th?id=OSK.6a5f75c9e4f2cbbbe916a6aa19763a35',
        description: 'Bún riêu',
        category: 'Món chính',
        rating: 4.5,
        reviewCount: 100,
        shopId: 1,
         shopName: "aa",
        distance: 2.2,
      ),
      quantity: 1,
    ),
  ];
  late Shop shop = Shop(
      id: 1,
      name: 'Quán ăn ngon',
      address: '123 Đường ABC, Quận XYZ, TP.HCM',
      phone: '0987654321',
      email: 'a@gmail.com',
      website: 'abc.com',
      longtiude: '10,23494',
      logo:
          'https://th.bing.com/th/id/OIP.w8GMRtBU7GOWXzf6ebKGJwHaHa?rs=1&pid=ImgDetMain',
      description: 'Giới thiệu',
      bankName: 'BIDV',
      bankNumber: '123456789');
  final User user = User(
    id: 1,
    name: 'Nguyễn Văn A',
    email: 'email@example.com',
    phone: '0123456789',
    address: '123 Đường ABC, Quận XYZ, TP. HCM',
    avatarUrl:
        'https://th.bing.com/th/id/OIP.w8GMRtBU7GOWXzf6ebKGJwHaHa?rs=1&pid=ImgDetMain',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final Address primaryAddress = Address(
    id: 1,
    name: 'Nguyễn Văn A',
    address: '123 Đường ABC, Quận XYZ, TP. HCM',
    phone: '0123456789',
    isDefault: true,
  );

  double calculateTotalPrices() {
    return items.fold<double>(
        0, (previousValue, element) => previousValue + element.totalPrice);
  }

  void handleOrder() {
    if (_paymentMethod == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn phương thức thanh toán'),
        ),
      );
      return;
    }

    // Handle order
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng'),
      ),
      bottomNavigationBar:
          OrderScreenBottomAppBar(totalPrices: calculateTotalPrices()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 8.0, bottom: 8.0, right: 15.0),
                          child: Text(
                            "Thông tin giao hàng",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(primaryAddress.name),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(primaryAddress.phone),
                              Text(primaryAddress.address),
                            ]),
                        trailing: TextButton(
                          onPressed: () {
                            // Navigate to address screen
                          },
                          child: const Text('Thay đổi'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 8.0, bottom: 8.0, right: 15.0),
                          child: Text(
                            "Danh sách món",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item.food.imageUrl as String,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(item.food.name as String),
                              subtitle: Text('Số lượng: ${item.quantity}'),
                              trailing: Text('Tổng cộng: ${item.totalPrice}'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 8.0, bottom: 8.0, right: 15.0),
                          child: Text(
                            "Ghi chú",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => note = value,
                        decoration: const InputDecoration(
                          hintText: 'Nhập ghi chú',
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 8.0, bottom: 8.0, right: 15.0),
                          child: Text(
                            "Phương thức thanh toán",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('Thanh toán khi nhận hàng'),
                              leading: Radio<int>(
                                value: PaymentMethod.COD,
                                groupValue: _paymentMethod,
                                onChanged: (value) =>
                                    setState(() => _paymentMethod = value!),
                              ),
                            ),
                            ListTile(
                              title: const Text('VNPAY'),
                              leading: Radio<int>(
                                value: PaymentMethod.VNPAY,
                                groupValue: _paymentMethod,
                                onChanged: (value) =>
                                    setState(() => _paymentMethod = value!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

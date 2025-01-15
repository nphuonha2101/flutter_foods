import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/payment_method.dart';
import 'package:flutter_foods/data/models/address.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/order_item.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/presentation/widgets/order_screen_bottom_app_bar.dart';
import 'package:flutter_foods/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_foods/data/models/food_cart_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _paymentMethod = -1;
  String note = '';
  late Map<int, List<OrderItem>> itemsByIdShops;
  int id_address = 1;

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
    isDefault: false,
    userId: 1,
  );

  @override
  void initState() {
    super.initState();

    List<OrderItem> orderItems = [];
    List<int> id_shops = [];
    itemsByIdShops = {}; // Map<int, List<OrderItem>>

    List<CartItem> cartItems = Provider.of<CartProvider>(context, listen: false).getCartItems();
    for (CartItem cartItem in cartItems){
       for (FoodCartItem foodsShopItem in cartItem.items){
            OrderItem orderItem = OrderItem(
                  foodId: foodsShopItem.food.id,
                  quantity: foodsShopItem.quantity,
                  price: foodsShopItem.food.price,
                  id: 0,
            );
            if (!id_shops.contains(foodsShopItem.food.shopId)) {
              id_shops.add(foodsShopItem.food.shopId);
            }
            if (itemsByIdShops[foodsShopItem.food.shopId] == null) {
                itemsByIdShops[foodsShopItem.food.shopId] = [];
            }
            itemsByIdShops[foodsShopItem.food.shopId]!.add(orderItem);
         }
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng'),
      ),
      bottomNavigationBar:
          OrderScreenBottomAppBar(
          totalPrices: context.watch<CartProvider>().getTotalPrice(),
          paymentMethod: _paymentMethod,
          itemsByIdShops: itemsByIdShops,
          note: note,
          idAddress: id_address,
          ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Address Section
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
              
              // Order Items Section
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
                        child: Column(
                          children: itemsByIdShops.keys.map((shopId) {
                            final orderItems = itemsByIdShops[shopId]!;
                            final totalPrice = orderItems.fold(
                                0.0, (sum, item) => sum + (item.price * item.quantity));

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Shop $shopId',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    ...orderItems.map((orderItem) {
                                      return ListTile(
                                        leading: Icon(Icons.food_bank), 
                                        title: Text('Món: ${orderItem.foodId}'),
                                        subtitle: Text('Số lượng: ${orderItem.quantity}'),
                                        trailing: Text('Giá: ${orderItem.price * orderItem.quantity}'),
                                      );
                                    }).toList(),
                                    const SizedBox(height: 10),
                                    Text('Tổng cộng: $totalPrice'),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Note Section
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
              
              // Payment Method Section
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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

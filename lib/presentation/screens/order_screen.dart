import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/payment_method.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/address.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/order_item.dart';
import 'package:flutter_foods/presentation/widgets/order_screen_bottom_app_bar.dart';
import 'package:flutter_foods/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_foods/data/models/food_cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _paymentMethod = -1;
  String note = 'null';
  late Map<int, List<OrderItem>> itemsByIdShops = {};
  int id_address = 1;
  late List<CartItem> cartItems = [];
  late SharedPreferences prefs;
  Address? primaryAddress;

  @override
  void initState() {
    super.initState();
    _loadCartItem();
    _loadAddress();
  }
void _loadCartItem() {
     // Initialize collections
      List<int> id_shops = [];
      itemsByIdShops = {};
          cartItems = Provider.of<CartProvider>(context, listen: false).getCartItems();
    for (CartItem cartItem in cartItems) {
      for (FoodCartItem foodsShopItem in cartItem.items) {
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
  Future<void> _loadAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final primaryAddressJson = prefs.getString('defaultAddress');

      if (primaryAddressJson != null) {
        setState(() {
          primaryAddress =
              Address.fromJsonStatic(jsonDecode(primaryAddressJson))
                  as Address?;
          id_address = primaryAddress?.id ?? 0; // Safe access
        });
      }
      // Continue with rest of initialization
      if (primaryAddress == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn địa chỉ giao hàng'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Không thể tải địa chỉ'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
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
    // Handle order processing here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng'),
      ),
      bottomNavigationBar: OrderScreenBottomAppBar(
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
              buildAddressSection(),
              buildOrderItemsSection(),
              buildNoteSection(),
              buildPaymentMethodSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildSectionTitle("Thông tin giao hàng"),
            ListTile(
              title: Text(primaryAddress?.name ?? "Chưa có địa chỉ"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(primaryAddress?.phone ?? ""),
                  Text(primaryAddress?.address ?? ""),
                ],
              ),
              trailing: TextButton(
                onPressed: () {
                  // Navigate to address screen
                  Navigator.pushNamed(context, AppRoutes.chooseAddress);
                },
                child: const Text('Thay đổi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderItemsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildSectionTitle("Danh sách đơn"),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap:
                  true, // Set shrinkWrap to true to prevent ListView from taking too much space
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling for this ListView since SingleChildScrollView handles scrolling
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                final totalPrice = cartItem.totalPrice;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '${cartItem.shopName}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: cartItem.items.map((orderItem) {
                            return ListTile(
                              leading: Icon(Icons.food_bank),
                              title: Text('Món: ${orderItem.food.name}'),
                              subtitle: Text('Số lượng: ${orderItem.quantity}'),
                              trailing: Text('Giá: ${orderItem.totalPrice}'),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        Text('Tổng cộng: $totalPrice'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoteSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildSectionTitle("Ghi chú"),
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
    );
  }

  Widget buildPaymentMethodSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildSectionTitle("Phương thức thanh toán"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
    );
  }

  Widget buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 8.0,
          bottom: 8.0,
          right: 15.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

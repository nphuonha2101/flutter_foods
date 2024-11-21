import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/shop.dart';
import 'package:flutter_foods/presentation/widgets/order_screen_bottom_app_bar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<CartItem> items = [];
  late Shop shop;

  double calculateTotalPrices() {
    return items.fold<double>(
        0, (previousValue, element) => previousValue + element.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng'),
      ),
      bottomNavigationBar:
          OrderScreenBottomAppBar(totalPrices: calculateTotalPrices()),
      body: items.isEmpty
          ? const Center(
              child: Text('Không có sản phẩm nào trong giỏ hàng'),
            )
          : Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        shop.logo,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // Display the shop name
                          shop.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // Display the shop address
                          shop.address,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              item.food.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.food.name),
                                Text('${item.food.price} VNĐ'),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Text('Số lượng: ${item.quantity}'),
                        trailing: Text('Tổng cộng: ${item.totalPrice}'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

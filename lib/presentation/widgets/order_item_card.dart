import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/order_status.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/order.dart';
import 'package:flutter_foods/providers/foods_provider.dart';
import 'package:provider/provider.dart';

class OrderItemCard extends StatelessWidget {
  final Order order;

  const OrderItemCard({super.key, required this.order});

  Future<Food> _fetchFood(BuildContext context, int foodId) async {
    final food =
        await Provider.of<FoodsProvider>(context, listen: false).fetch(foodId);
    if (food == null) {
      throw Exception('Food not found');
    }
    return food;
  }

  void handleCancelOrder(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final List orderItems = order.items;

    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/food_delivery.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Best Food Shop'),
                    ],
                  ),
                  Text(
                    OrderStatus.getStatus(order.status),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final orderItem = orderItems[index];
                  final int foodId = orderItem['foodId'];
                  return FutureBuilder<Food>(
                    future: _fetchFood(context, foodId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error fetching food details'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('Food not found'));
                      } else {
                        final food = snapshot.data!;
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              food.imageUrl ??
                                  'https://blog.snappymob.com/wp-content/uploads/2020/12/8-Tips-for-Designing-Empty-Placeholder-Pages-Leni-Featured.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(food.name ?? 'Không xác định'),
                          subtitle: Text('x${orderItem.quantity}'),
                          trailing: Text('${orderItem['price']}đ'),
                        );
                      }
                    },
                  );
                },
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text('Tổng cộng:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Text('300.000đ'),
                    ],
                  ),
                  if (order.status == OrderStatus.PREPARING)
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor:
                              Theme.of(context).colorScheme.onError),
                      child: const Text('Hủy đơn'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

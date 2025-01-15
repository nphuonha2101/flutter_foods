import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/order_status.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/order.dart';
import 'package:flutter_foods/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderItemCard extends StatefulWidget {
  final Order order;
  const OrderItemCard({super.key, required this.order});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  @override
  void initState() {
    super.initState();
  }

  int calcTotalAmount() {
    return widget.order.items.fold(
        0,
        (previousValue, orderItem) =>
            previousValue + (orderItem.price * orderItem.quantity));
  }

  void handleCancelOrder() {
    try {
      context.read<OrderProvider>().cancelOrder(widget.order.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Hủy đơn hàng thành công'),
          backgroundColor: Colors.green[600],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Hủy đơn hàng thất bại'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
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
                    OrderStatus.getStatus(widget.order.status),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const Divider(),

              // Food Items List
              Column(
                children: widget.order.items
                    .map((orderItem) =>
                        _buildFoodItem(orderItem, orderItem.food))
                    .toList(),
              ),
              const Divider(),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Tổng cộng:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${calcTotalAmount()}đ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  if (widget.order.status == OrderStatus.PREPARING)
                    ElevatedButton(
                      onPressed: handleCancelOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Theme.of(context).colorScheme.onError,
                      ),
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

  Widget _buildFoodItem(dynamic orderItem, Food? food) {
    return ListTile(
      leading: SizedBox(
        width: 40,
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            food?.imageUrl ?? 'https://via.placeholder.com/40',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 40,
                height: 40,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              );
            },
          ),
        ),
      ),
      title: Text(food?.name ?? 'Không xác định'),
      subtitle: Text('x${orderItem.quantity}'),
      trailing: Text('${orderItem.price}đ'),
    );
  }
}

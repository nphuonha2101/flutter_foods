import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/widgets/order_item_card.dart';
import 'package:flutter_foods/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  final int status;

  const OrderList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    List orders = orderProvider.orders;

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderItemCard(order: orders[index]);
      },
    );
  }
}

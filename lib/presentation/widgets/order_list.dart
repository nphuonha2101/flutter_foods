import 'package:flutter/material.dart';
import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/presentation/widgets/order_item_card.dart';
import 'package:flutter_foods/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  final int status;

  const OrderList({super.key, required this.status});

  @override
  State<OrderList> createState() {
    return _OrderListState();
  }
}

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchByStatus(widget.status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        final orders = orderProvider.orders;

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return OrderItemCard(order: orders[index]);
          },
        );
      },
    );
  }
}

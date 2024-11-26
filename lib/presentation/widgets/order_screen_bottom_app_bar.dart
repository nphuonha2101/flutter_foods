import 'package:flutter/material.dart';

class OrderScreenBottomAppBar extends StatelessWidget {
  final double totalPrices;

  const OrderScreenBottomAppBar({super.key, required this.totalPrices});

  void _placeOrder() {
    // Implement place order logic here
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: FilledButton(
        onPressed: _placeOrder,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Đặt hàng ${"($totalPricesđ)"}",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

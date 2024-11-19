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
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng cộng: $totalPrices VNĐ',
            ),
            ElevatedButton(
              onPressed: _placeOrder,
              child: const Text('Đặt hàng'),
            ),
          ],
        ),
      ),
    );
  }
}

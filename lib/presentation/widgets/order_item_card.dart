import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({super.key});

  void cancelOrder() {
    // Hủy đơn hàng
  }

  @override
  Widget build(BuildContext context) {
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
                    "Đang chuẩn bị",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  )
                ],
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/food_delivery.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: const Text('Mì xào giòn'),
                    subtitle: const Text('x1'),
                    trailing: const Text('100.000đ'),
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
                  ElevatedButton(
                    onPressed: cancelOrder,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Theme.of(context).colorScheme.onError),
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

import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/widgets/order_item_card.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() {
    return _MyOrderScreenState();
  }
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đơn hàng của tôi'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(TablerIcons.microwave), text: "Đang chuẩn bị"),
              Tab(
                  icon: Icon(TablerIcons.truck_delivery),
                  text: "Đang vận chuyển"),
              Tab(icon: Icon(TablerIcons.soup), text: "Đã giao"),
              Tab(icon: Icon(TablerIcons.x), text: "Đã hủy"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const OrderItemCard();
              },
            ),
            Center(child: Text("Đang chuẩn bị ")),
            Center(child: Text("Đã giao")),
            Center(child: Text("Đã hủy")),
          ],
        ),
      ),
    );
  }
}

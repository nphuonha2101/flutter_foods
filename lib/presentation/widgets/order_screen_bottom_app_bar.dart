import 'package:flutter/material.dart';
import 'package:flutter_foods/data/dtos/order_dto.dart';
import 'package:flutter_foods/data/dtos/order_item_dto.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/data/models/order_item.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:flutter_foods/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderScreenBottomAppBar extends StatelessWidget {
  const OrderScreenBottomAppBar({
    super.key,
    required this.paymentMethod,
    required this.idAddress,
    required this.totalPrices,
    required this.itemsByIdShops,
    required this.note, 
  });

  final int paymentMethod;
  final int idAddress;
  final double totalPrices;
  final Map<int, List<OrderItem>> itemsByIdShops;
  final String note;

  void _placeOrder(BuildContext context) async {
  List<OrderDto> items = [];
  String? token;
    token = await Provider.of<AuthProvider>(context, listen: false).getToken();
  
  if (token == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Vui lòng đăng nhập để tiếp tục đặt hàng!')),
    );
    return;  
  }

  itemsByIdShops.forEach((shopId, orderItems) {
    List<OrderItemDto> orderItemDtos = orderItems
        .map((orderItem) => orderItem.toDto())
        .toList()
        .cast<OrderItemDto>();

    items.add(OrderDto(
      shopId: shopId,
      totalPrice: totalPrices,
      addressId: idAddress,
      note: note,
      paymentMethod: paymentMethod == 0 ? "tiền mặt" : "VNPAY",
      items: orderItemDtos,
      token: token!,
    ));
  });

  try {
    for (var order in items) {
      print(order.toJson());
      await Provider.of<OrderProvider>(context, listen: false).create(order);
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đặt hàng thành công!')));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đặt hàng thất bại!'+e.toString())));
  }
}


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: FilledButton(
        onPressed: () => _placeOrder(context),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Đặt hàng ${"($totalPrices đ)"}",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

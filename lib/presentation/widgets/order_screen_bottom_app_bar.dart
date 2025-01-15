import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/payment_method.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/dtos/order_dto.dart';
import 'package:flutter_foods/data/dtos/order_item_dto.dart';
import 'package:flutter_foods/data/models/order_item.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:flutter_foods/providers/cart_provider.dart';
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
  final int totalPrices;
  final Map<int, List<OrderItem>> itemsByIdShops;
  final String note;

  void _placeOrder(BuildContext context) async {
    if (paymentMethod == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn phương thức thanh toán'),
        ),
      );
      return;
    }
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
        paymentMethod:
            paymentMethod == PaymentMethod.COD ? "tiền mặt" : "VNPAY",
        items: orderItemDtos,
        token: token!,
      ));
    });
    for (var order in items) {
      await Provider.of<OrderProvider>(context, listen: false).create(order);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Đặt hàng thành công!')));
    Navigator.pushNamed(context, AppRoutes.home);
    Provider.of<CartProvider>(context, listen: false).clearCart();
    
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

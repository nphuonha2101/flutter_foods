import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/dtos/order_item_dto.dart';

class OrderDto implements IDto {
  final int shopId;
  final int totalPrice;
  final int addressId;
  final String note;
  final String paymentMethod;
  final List<OrderItemDto> items;

  OrderDto({
    required this.shopId,
    required this.totalPrice,
    required this.addressId,
    required this.note,
    required this.paymentMethod,
    required this.items,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'shop_id': shopId,
      'total_price': totalPrice,
      'address_id': addressId,
      'note': note,
      'payment_method': paymentMethod,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

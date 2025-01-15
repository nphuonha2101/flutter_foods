import 'package:flutter_foods/data/dtos/i_dto.dart';

class OrderItemDto implements IDto {
  final int foodId;
  final int quantity;
  final int price;
  final int orderId;

  OrderItemDto({
    required this.foodId,
    required this.quantity,
    required this.price,
    this.orderId = 0,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'quantity': quantity,
      'price': price,
      'order_id': orderId,
    };
  }
}

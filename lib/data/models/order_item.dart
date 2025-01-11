import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/dtos/order_item_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class OrderItem implements IModel {
  final int foodId;
  final int quantity;
  final double price;
  final int orderId;

  OrderItem({
    required this.foodId,
    required this.quantity,
    required this.price,
    this.orderId = 0,
  });

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return OrderItem(
      foodId: json['food_id'],
      quantity: json['quantity'],
      price: json['price'],
      orderId: json['order_id'],
    );
  }

  @override
  IDto toDto() {
    return OrderItemDto(
      foodId: foodId,
      quantity: quantity,
      price: price,
      orderId: orderId,
    );
  }

  static IModel fromJsonStatic(Map<String, dynamic> json) {
    return OrderItem(
      foodId: json['food_id'],
      quantity: json['quantity'],
      price: json['price'],
      orderId: json['order_id'],
    );
  }
}

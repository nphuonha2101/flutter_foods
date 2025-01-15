import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/dtos/order_item_dto.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class OrderItem implements IModel {
  final int id;
  final int foodId;
  final int quantity;
  final int price;
  final int orderId;
  final Food? food;

  OrderItem(
      {required this.id,
      required this.foodId,
      required this.quantity,
      required this.price,
      this.orderId = 0,
      this.food});

  @override
  IDto toDto() {
    return OrderItemDto(
      foodId: foodId,
      quantity: quantity,
      price: price,
      orderId: orderId,
    );
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as int? ?? 0,
      foodId: json['food_id'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 1,
      price: json['price'] as int? ?? 0,
      orderId: json['order_id'] as int? ?? 0,
      food: json['food'] != null
          ? Food.fromJsonStatic(json['food'] as Map<String, dynamic>) as Food
          : null,
    );
  }

  static IModel fromJsonStatic(Map<String, dynamic> json) {
    try {
      return OrderItem(
        id: json['id'] as int? ?? 0,
        foodId: json['food_id'] as int? ?? 0,
        quantity: json['quantity'] as int? ?? 1,
        price: json['price'] as int? ?? 0,
        orderId: json['order_id'] as int? ?? 0,
        food: json['food'] != null
            ? Food.fromJsonStatic(Map<String, dynamic>.from(json['food']))
                as Food
            : null,
      );
    } catch (e) {
      AppLogger.error('OrderItem.fromJsonStatic: $e\nJSON: $json');
      return OrderItem(
        id: 0,
        foodId: 0,
        quantity: 0,
        price: 0,
        orderId: 0,
      );
    }
  }
}

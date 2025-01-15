import 'package:flutter_foods/data/models/food.dart';

class FoodCartItem {
  final Food food;
  int quantity = 1;
  bool isChecked;

  FoodCartItem({
    required this.food,
    required this.quantity,
    this.isChecked = false,
  });
  int get totalPrice => food.price * quantity;
  FoodCartItem.copy(FoodCartItem other)
      : food = other.food,
        quantity = other.quantity,
        isChecked = other.isChecked;
}

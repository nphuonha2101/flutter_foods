import 'package:flutter_foods/data/models/food.dart';

class CartItem {
  final Food food;
  int quantity;
  bool isChecked; // New property to track if the item is checked

  CartItem({
    required this.food,
    required this.quantity,
    this.isChecked = false, // Default value for isChecked
  });
  double get totalPrice => food.price * quantity;
}

import 'package:flutter_foods/data/models/food.dart';

class CartItem {
  final Food food;
  int quantity =1;
  bool isChecked; 

  CartItem({
    required this.food,
    required this.quantity,
    this.isChecked = false, 
  });
  double get totalPrice => food.price * quantity;
CartItem.copy(CartItem other)
      : food = other.food,
        quantity = other.quantity,
        isChecked = other.isChecked;

}

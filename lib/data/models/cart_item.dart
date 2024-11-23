import 'package:flutter_foods/data/models/food.dart';

class CartItem {
  final Food food;
  int quantity;
  bool isChecked; 

  CartItem({
    required this.food,
    required this.quantity,
    this.isChecked = false, 
  });
  double get totalPrice => food.price * quantity;
}

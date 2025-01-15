
import 'package:flutter_foods/data/models/food_cart_item.dart';
class CartItem {
  String shopName;
  List<FoodCartItem> items;
  bool isChecked;
  CartItem({
    required this.items,
    this.isChecked = false, 
    required this.shopName,
  });
  double get totalPrice {
    return items.fold(0.0, (sum, item) => sum + item.food.price * item.quantity);
  }

}
  
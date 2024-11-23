import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/food.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get items => _cartItems;

  void addToCart(CartItem foodItem) {

    bool itemExists = false;
    for (var item in _cartItems) {
      if (item.food.id == foodItem.food.id) {
        itemExists = true;
        item.quantity += foodItem.quantity; 
        break;
      }
    }

    if (!itemExists) {
      _cartItems.add(foodItem); 
    }

    notifyListeners(); 
  }
  double get totalCartPrice => _cartItems.fold(
      0, (total, cartItem) => total + cartItem.totalPrice);

  void addItem(CartItem item) {
    final index =
        _cartItems.indexWhere((cartItem) => cartItem.food.id == item.food.id);

    if (index >= 0) {
      _cartItems[index].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }

    notifyListeners();
  }

  void removeItem(String foodId) {
    _cartItems.removeWhere((cartItem) => cartItem.food.id == foodId);
    notifyListeners();
  }

  void updateQuantity(int foodId, int quantity) {
    final index =
        _cartItems.indexWhere((cartItem) => cartItem.food.id == foodId);

    if (index >= 0) {
      _cartItems[index].quantity = quantity;
      if (_cartItems[index].quantity <= 0) {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void toggleItemChecked(String foodId) {
    final index =
        _cartItems.indexWhere((cartItem) => cartItem.food.id == foodId);

    if (index >= 0) {
      _cartItems[index].isChecked = !_cartItems[index].isChecked;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

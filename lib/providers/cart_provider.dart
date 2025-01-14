import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  final List<CartItem> _selectedItems = [];

  List<CartItem> get cartItems => _cartItems;
  List<CartItem> get selectedItems => _selectedItems;

  void addToCart(CartItem foodItem) {
    bool itemExists = false;
     CartItem newItem = CartItem.copy(foodItem); 
    for (var item in _cartItems) {
      if (item.food.id == newItem.food.id) {
        itemExists = true;
        item.quantity += newItem.quantity; 
        
        break;
      }
    }

    if (!itemExists) {
      _cartItems.add(newItem); 
    }

    notifyListeners(); 
  }

  void toggleSelection(CartItem item) {
    print(item.isChecked);
    if (item.isChecked) {
      _selectedItems.add(item); 
    } else {
      _selectedItems.remove(item); 
    }
    notifyListeners();
  }
 void toggleSelectAll(bool value) {
  if(value){

    for (var item in cartItems) {
     _selectedItems.add(item);
    }
  }else{
     for (var item in cartItems) {
     _selectedItems.remove(item);
  }
  notifyListeners();
  }
}

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity >= 1) {
      item.quantity--;
      notifyListeners();
    }
  }

 void removeItem(CartItem item) {
  bool removedFromCart = _cartItems.remove(item);
  bool removedFromSelected = _selectedItems.remove(item);
  
  if (removedFromCart || removedFromSelected) {
    notifyListeners();
  }
}
}


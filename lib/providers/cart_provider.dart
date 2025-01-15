import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/food_cart_item.dart';
class CartProvider extends ChangeNotifier {

  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  // Thêm món ăn vào giỏ hàng
  void addToCart(FoodCartItem foodItem) {
    bool itemExistsInCart = false;
    FoodCartItem newItem = FoodCartItem.copy(foodItem);
    newItem.isChecked = false;
    for (var cartItem in _cartItems) {
      if (cartItem.items.isNotEmpty &&
          cartItem.items.first.food.shopId == foodItem.food.shopId) {
        for (var existingItem in cartItem.items) {
          if (existingItem.food.id == foodItem.food.id) {
            existingItem.quantity++;
            itemExistsInCart = true;
            break;
          }
        }
        if (!itemExistsInCart) {
          cartItem.items.add(newItem);
          itemExistsInCart = true;
        }
        break;
      }
    }

    if (!itemExistsInCart) {
      _cartItems.add(CartItem(items: [newItem], isChecked: false, shopName: newItem.food.shopName));
    }

    notifyListeners();
  }

void toggleFoodSelection(FoodCartItem foodItem) {
    if (foodItem.isChecked) {
      for( var shopitem in _cartItems){
       if(shopitem.shopName==foodItem.food.shopName){
          for (var fooditem in shopitem.items) {
            if(foodItem.food.id==fooditem.food.id){
              fooditem.isChecked = true;
            }
          }
       }
      }
    } else {
       for( var shopitem in _cartItems){
       if(shopitem.shopName==foodItem.food.shopName){
          for (var fooditem in shopitem.items) {
            if(foodItem.food.id==fooditem.food.id){
              fooditem.isChecked = false;
            }
          }
       }
      }
    }
   
    notifyListeners();
}

  // Hàm chọn hoặc bỏ chọn cửa hàng (tất cả món ăn của cửa hàng đó)
  void toggleShopSelection(CartItem cartItem) {

    for (var food in cartItem.items) {
      food.isChecked = cartItem.isChecked;
    }

    notifyListeners();
  }


  // Hàm chọn tất cả món ăn trong giỏ
  void toggleSelectAll(bool value) {
    for (var cartItem in _cartItems) {
      cartItem.isChecked = value;
      for (var food in cartItem.items) {
        food.isChecked = value;
      }
    
    }
    notifyListeners();
  }

  // Tăng số lượng món ăn
  void increaseQuantity(FoodCartItem item) {
    for (var cartItem in _cartItems) {
      if (cartItem.items.contains(item)) {
        item.quantity++;
        break;
      }
    }
    notifyListeners();
  }

  // Giảm số lượng món ăn
  void decreaseQuantity(FoodCartItem item) {
    for (var cartItem in _cartItems) {
      if (cartItem.items.contains(item)) {
        if (item.quantity > 1) {
          item.quantity--;
        }
        break;
      }
    }
    notifyListeners();
  }

  // Xóa cửa hàng khỏi giỏ hàng
  void removeItemShop(CartItem itemsShop) {
    _cartItems.remove(itemsShop);
    notifyListeners();
  }
  // Xóa món ăn khỏi giỏ hàng
  void removeItem(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  // Xóa tất cả giỏ hàng
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Tính tổng giá trị của các món ăn được chọn
  double getTotalPrice() {
    double total = 0.0;
    for (var cartItem in cartItems) {
      if(cartItem.isChecked){
        for (var foodItem in cartItem.items) {
          if(foodItem.isChecked){
            total += foodItem.food.price * foodItem.quantity;
          }
        }
      }
    }
    return total;
  }
  List<CartItem> getCartItems(){
  List<CartItem> list = [];
  for(var cartItem in _cartItems){
    if(cartItem.isChecked){
      list.add(cartItem);
    }
  }
  return list;
}
}


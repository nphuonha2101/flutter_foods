import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/food_cart_item.dart';
import 'package:flutter_foods/presentation/widgets/food_cart_card.dart';
import 'package:flutter_foods/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider cart;
  bool selectAll = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cart = Provider.of<CartProvider>(context);
  }

  // Toggle select all items in the cart
  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var item in cart.cartItems) {
        item.isChecked = selectAll; 
        for (var foodItem in item.items) {
          foodItem.isChecked = selectAll; 
        }
      }
    });
    cart.toggleSelectAll(selectAll); 
  }

  void onFoodItemChecked(FoodCartItem foodItem, CartItem shopItem) {
     setState(() {
     foodItem.isChecked = !foodItem.isChecked;
    if (foodItem.isChecked) {
      shopItem.isChecked = true;
    } 
  });
    cart.toggleFoodSelection(foodItem ); 
  }

  // Toggle selection for a specific shop
  void onShopItemChecked(CartItem cartItem) {
    setState(() {
      bool newCheckState = !cartItem.isChecked;
      cartItem.isChecked = newCheckState;
      for (var foodItem in cartItem.items) {
        foodItem.isChecked = newCheckState;
      }
    });
    cart.toggleShopSelection(cartItem); 
  }

  @override
  Widget build(BuildContext context) {
    final groupedItems = cart.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Giỏ hàng '),
            Text(
              '(${cart.cartItems.length})',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber[700]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Select All Checkbox
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Checkbox(
                  value: selectAll,
                  onChanged: _toggleSelectAll,
                ),
                const Text(
                  'Chọn tất cả',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          // List of Cart Items
          Expanded(
            child: ListView.builder(
              itemCount: groupedItems.length,
              itemBuilder: (context, index) {
                final shopItems = groupedItems[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FoodCartCard(
                      cartItem: CartItem(
                        items: shopItems.items,
                        shopName: shopItems.shopName,
                      ),
                      isCheckedShop: shopItems.isChecked,
                      onShopChecked: () => onShopItemChecked(shopItems),
                      onFoodItemChecked: (FoodCartItem foodItem) => onFoodItemChecked(foodItem, shopItems),
                      onIncrease: (FoodCartItem item) {
                        setState(() {
                          cart.increaseQuantity(item);
                        });
                      },
                      onDecrease: (FoodCartItem item) {
                        setState(() {
                          cart.decreaseQuantity(item);
                        });
                      },
                      onDeleteShop: (CartItem item) {
                        setState(() {
                          cart.removeItemShop(item);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tổng tiền:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\đ${cart.getTotalPrice().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.checkout),
                    child: const Text('Mua hàng'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

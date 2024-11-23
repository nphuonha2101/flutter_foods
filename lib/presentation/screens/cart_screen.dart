import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
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

  // Calculate total cost of items in cart
  double getCartTotal() {
    return cart.items.fold(0.0, (total, item) => total + item.totalPrice);
  }

  // Handle "Select All" checkbox
  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
    });
    // You can modify the selection logic to update the individual items as well

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Text('Giỏ hàng '),
          Text('(${cart.items.length})', style: const TextStyle(fontSize: 18)),
        ]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber[700]),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: ListView(
              children: cart.items.map((item) {
                return FoodCartCard(
                  cartItems: [item],
                  onIncrease: (CartItem item) {
                    setState(() {
                      cart.updateQuantity(item.food.id, item.quantity + 1);
                    });
                  },
                  onDecrease: (CartItem item) {
                    setState(() {
                      if (item.quantity > 1) {
                        cart.updateQuantity(item.food.id, item.quantity - 1);
                      }
                    });
                  },

                );
              }).toList(),
            ),
          ),

          // footer
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dòng 1: Chọn Voucher
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chọn voucher:',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle voucher selection

                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Chọn hoặc nhập mã voucher',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),

                // Dòng 2: Checkbox chọn tất cả
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: selectAll,
                          onChanged: _toggleSelectAll,
                        ),
                        const Text('Tất cả', style: TextStyle(fontSize: 14)),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tổng tiền:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'đ${getCartTotal().toStringAsFixed(0)}',
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
                        onPressed: () {
                          // Handle purchase button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Button color
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Mua hàng'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

  double getCartTotal() {
    return cart.cartItems.fold(0.0, (total, item) => total + item.totalPrice);
  }

void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value!;
      for (var item in cart.cartItems) {
        item.isChecked = selectAll;
      }
    cart.toggleSelectAll(value);
    });
  }
   void onItemChecked(CartItem cartItem) {
    setState(() {
      cartItem.isChecked = !cartItem.isChecked;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Text('Giỏ hàng '),
          Text('(${cart.cartItems.length})', style: const TextStyle(fontSize: 18)),
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
              children: cart.cartItems.map((item) {
                return FoodCartCard(
                  cartItem: item,
                  onChecked: (CartItem item) {
                    onItemChecked(item);
                  },
                  onIncrease: (CartItem item) {
                    setState(() {
                      cart.increaseQuantity(item);
                    });
                  },
                  onDecrease: (CartItem item) {
                    setState(() {
                      if (item.quantity > 1) {
                          cart.decreaseQuantity(item);
                      }
                    });
                  },
                  onDelete:(CartItem item) {
                    setState(() {
                      if (item.quantity >= 1) {
                          cart.removeItem(item);
                      }
                    });
                  } ,

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
                          print('Selected item: ${cart.selectedItems.length}'); 
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

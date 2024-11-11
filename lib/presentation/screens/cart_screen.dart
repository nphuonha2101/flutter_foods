import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // Import collection package for groupBy
import 'package:flutter_foods/data/models/CartItem.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/presentation/widgets/food_cart_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart data
  List<CartItem> items = [
    CartItem(
      food: Food(
        id: 1,
        name: 'Pepperoni Pizza',
        category: 'Pizza House',
        price: 12.99,
        rating: 4.7,
        reviewCount: 150,
        imageUrl: 'assets/images/food_delivery.png',
        angencyId: 101,
      ),
      quantity: 2,
    ),
    CartItem(
      food: Food(
        id: 1,
        name: 'Pepperoni Pizza 1',
        category: 'Pizza House',
        price: 12.99,
        rating: 4.7,
        reviewCount: 150,
        imageUrl: 'assets/images/food_delivery.png',
        angencyId: 101,
      ),
      quantity: 2,
    ),
    CartItem(
      food: Food(
        id: 2,
        name: 'Cheeseburger',
        category: 'Burger Town',
        price: 9.49,
        rating: 4.5,
        reviewCount: 200,
        imageUrl: 'assets/images/food_delivery.png',
        angencyId: 102,
      ),
      quantity: 1,
    ),
    CartItem(
      food: Food(
        id: 3,
        name: 'Veggie Salad',
        category: 'Healthy Eatery',
        price: 7.99,
        rating: 4.3,
        reviewCount: 80,
        imageUrl: 'assets/images/food_delivery.png',
        angencyId: 103,
      ),
      quantity: 3,
    ),
  ];

  // Grouping the cart items by their category
  Map<String, List<CartItem>> getGroupedItems() {
    return groupBy(items, (CartItem item) => item.food.category);
  }

  double getCartTotal() {
    double total = 0.0;
    for (var item in items) {
      total += item.totalPrice; 
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final groupedItems = getGroupedItems();

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text('Giỏ hàng '),
          Text('('+items.length.toString() +")",style: TextStyle(fontSize: 18,))
        ],),
         leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.amber[700],),
          onPressed: () {
            Navigator.pop(context); 
          },
  ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: groupedItems.entries.map((entry) {
                final categoryItems = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FoodCartCard(
                      cartItems: categoryItems,
                       onIncrease: (CartItem item) {
                          setState(() {
                            item.quantity++;
                          });
                        },
                        onDecrease: (CartItem item) {
                          setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                            }
                          });
                        },
                    ),
                    
                  ],
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
                offset: Offset(0, -2), 
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
                  Text(
                    'Chọn voucher:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Xử lý khi chọn voucher
                    },
                     child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Chọn hoặc nhập mã voucher',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 14,
                          ),
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
                    value: false, // Thay đổi trạng thái checkbox theo nhu cầu
                    onChanged: (bool? value) {
                      // Xử lý khi chọn "Chọn tất cả"
                    },
                  ),
                  Text(
                    'Tất cả',
                    style: TextStyle(fontSize: 14),
                  )
                    ],
                  ),
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng tiền:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\đ${getCartTotal().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 150, // Chiều rộng của nút Mua hàng
                      child: ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nhấn nút Mua hàng
                        },
                        child: Text('Mua hàng'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Màu nền của nút
                          padding: EdgeInsets.symmetric(vertical: 14),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/data/models/food_cart_item.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class FoodCartCard extends StatefulWidget {
  final CartItem cartItem; // List of items from the same shop
  final bool isCheckedShop;
  final ValueChanged<FoodCartItem> onIncrease;
  final ValueChanged<FoodCartItem> onDecrease;
  final ValueChanged<CartItem> onDeleteShop;
  final VoidCallback onShopChecked;
  final ValueChanged<FoodCartItem> onFoodItemChecked; 

  const FoodCartCard({
    Key? key,
    required this.cartItem,
    required this.isCheckedShop,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDeleteShop,
    required this.onShopChecked,
    required this.onFoodItemChecked,
  }) : super(key: key);

  @override
  _FoodCartCardState createState() => _FoodCartCardState();
}

class _FoodCartCardState extends State<FoodCartCard> {
  late bool isCheckedShop;

  @override
  void initState() {
    super.initState();
    isCheckedShop = widget.cartItem.items.any((item) => item.isChecked);
  }

  @override
  Widget build(BuildContext context) {
    final shopName = widget.cartItem.shopName;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop name and checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: widget.isCheckedShop, // nhận giá trị từ bên ngoài
                      onChanged: (bool? value) {
                        setState(() {
                          widget.onShopChecked(); // gọi hàm khi checkbox cửa hàng thay đổi
                        });
                      },
                    ),
                    Text(
                      shopName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => widget.onDeleteShop(widget.cartItem),
                  child: Text(
                    "Xóa",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // List of items for this shop
            Column(
              children: widget.cartItem.items.map((cartItem) {
                bool isCheckedFood = cartItem.isChecked;
                final food = cartItem.food;
                final quantity = cartItem.quantity;

                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Checkbox(
                            value: isCheckedFood,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.onFoodItemChecked(cartItem); 
                              });
                            },
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[300],
                            child: Image.network(
                              food.imageUrl as String,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food.name as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                food.shopName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.amber[700]!,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "Giao hàng 5 phút",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.amber[700],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\đ${food.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Quantity and Total Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Material(
                              color: Theme.of(context).colorScheme.surfaceContainerLow,
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              child: IconButton(
                                padding: const EdgeInsets.all(2),
                                icon: const Icon(TablerIcons.minus, color: Colors.redAccent),
                                onPressed: () => widget.onDecrease(cartItem),
                              ),
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Material(
                              color: Theme.of(context).colorScheme.surfaceContainerLow,
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              child: IconButton(
                                padding: const EdgeInsets.all(2),
                                icon: const Icon(TablerIcons.plus, color: Colors.green),
                                onPressed: () => widget.onIncrease(cartItem),
                              ),
                            ),
                          ],
                        ),
                        // Display total price for the item
                        Text(
                          'Thành tiền: ₫${(food.price * quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ),
            // const Divider(),
            // // Total price for this shop
            // Column(
            //   children: [
            //     Text(

            //       'Total: \$${widget.cartItem.totalPrice}',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.green[700],
            //       ),
            //     ),
            //   ],
            // ),

          ],
        ),
      ),
    );
  }
}

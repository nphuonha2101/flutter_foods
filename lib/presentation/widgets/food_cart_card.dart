import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/CartItem.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class FoodCartCard extends StatefulWidget {
  final List<CartItem> cartItems; // List of items from the same shop
  final ValueChanged<CartItem> onIncrease;
  final ValueChanged<CartItem> onDecrease;

  const FoodCartCard({
    Key? key,
    required this.cartItems,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  _FoodCartCardState createState() => _FoodCartCardState();
}

class _FoodCartCardState extends State<FoodCartCard> {
  bool isCheckedShop = false;
  bool isEditing = false; // Add a state variable to track editing mode

  @override
  Widget build(BuildContext context) {
    final shopName = widget.cartItems.first.food.category;

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
                      value: isCheckedShop,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedShop = value!;
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
                  onTap: () {
                    setState(() {
                      isEditing = !isEditing; // Toggle editing mode
                    });
                  },
                  child: Text(
                    isEditing ? "Xong" : "Sửa", // Change text based on editing state
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // List of items for this shop
            Column(
              children: widget.cartItems.map((cartItem) {
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
                                cartItem.isChecked = value!;
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
                            child: Image.asset(
                              food.imageUrl,
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
                                food.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                               const SizedBox(height: 4),
                              Text(
                                food.category,
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
                                '\$${food.price.toStringAsFixed(2)}',
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              child: IconButton(
                                padding: const EdgeInsets.all(2),
                                icon: const Icon(TablerIcons.minus,
                                    color: Colors.redAccent),
                              onPressed: () => widget.onDecrease(cartItem),
                              ),
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Material(
                              color: Theme.of(context).colorScheme.surfaceContainerLow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
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
                          'Total: \$${(food.price * quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    if (isEditing) 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print("Sản phẩm tương tự clicked");
                            },
                             style: ElevatedButton.styleFrom(
                              iconColor: Colors.red, 
                              
                              backgroundColor:Theme.of(context).colorScheme.surfaceTint
                            ),
                            child: const Text("Sản phẩm tương tự", style: TextStyle(color: Colors.white),),
                          ),
                          ElevatedButton(
                            
                            onPressed: () {
                              print("Xóa sản phẩm clicked");
                              // Add your delete logic here
                            },
                            style: ElevatedButton.styleFrom(
                              iconColor: Colors.red, 
                            ),
                            child: Text("Xóa sản phẩm",
                            style: TextStyle(color:Theme.of(context).colorScheme.surfaceTint)),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ),
            const Divider(),
            // Total price for this shop
            Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   'Total: \$${widget.cartItems.fold(0.0, (sum, item) => sum + (item.food.price * item.quantity))}',
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.green[700],
                //   ),
                // ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Row(children: [
                         IconButton(
                      icon:  Icon(Icons.card_giftcard,color: Colors.amber[900] ,),
                      onPressed: () {
                        // Handle the button press action here
                      },
                    ),
                    const Text(
                      "Thêm shop voucher", 
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                      ),
                    ),
                    ],),
                     IconButton(
                        alignment: Alignment.centerRight,
                      icon: const Icon(Icons.arrow_forward_ios, size: 14,),
                      onPressed: () {
                        // Handle shipping action here
                      },
                     )
                  ],
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      IconButton(
                        icon: const Icon(Icons.local_shipping, color: Colors.green),
                        onPressed: () {
                        },
                      ),
                      Flexible(
                        flex: 1,
                        
                        child: Text(
                          "Giảm ₫300.000 phí vận chuyển đơn tối thiểu ₫0; Giảm ₫500.000 phí vận chuyển đơn tối thiểu ₫500.000", 
                          style: TextStyle(
                            fontSize: 12, 
                            color: Theme.of(context).colorScheme.onSurface, 
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis, 
                          softWrap: true, 
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        icon: const Icon(Icons.arrow_forward_ios, size: 14),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

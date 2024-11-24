import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class FoodCartCard extends StatefulWidget {
  final CartItem cartItem; // A single cart item from the same shop
  final ValueChanged<CartItem> onIncrease;
  final ValueChanged<CartItem> onDecrease;
  final ValueChanged<CartItem> onDelete; 
  final ValueChanged<CartItem> onChecked; 

  const FoodCartCard({
    super.key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
     required this.onChecked,
  });

  @override
  State<FoodCartCard> createState() => _FoodCartCardState();
}

class _FoodCartCardState extends State<FoodCartCard> {
  bool isEditing = false;      

  @override
  Widget build(BuildContext context) {
    final food = widget.cartItem.food;
    final quantity = widget.cartItem.quantity;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: widget.cartItem.isChecked,
                      onChanged: (bool? value) {
                       widget.onChecked(widget.cartItem);
                      },
                    ),
                    Text(
                      food.category,  // Use the food's category as the shop name
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
                    isEditing ? "Xong" : "Sửa", 
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Food item details
            Row(
              children: [
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
                        onPressed: () => widget.onDecrease(widget.cartItem),
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
                        onPressed: () => widget.onIncrease(widget.cartItem),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Total: \đ${(food.price * quantity).toStringAsFixed(0)}',
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
                      backgroundColor: Theme.of(context).colorScheme.surfaceTint,
                    ),
                    child: const Text(
                      "Sản phẩm tương tự",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("Xóa sản phẩm clicked: "+widget.cartItem.toString());
                     
                        widget.onDelete(widget.cartItem); 
                    },
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.red,
                    ),
                    child: Text(
                      "Xóa sản phẩm",
                      style: TextStyle(color: Theme.of(context).colorScheme.surfaceTint),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

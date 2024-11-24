import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/cart_item.dart';
import 'package:flutter_foods/providers/cart_provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class BottomFoodDetailAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final CartItem cartItem;  
  const BottomFoodDetailAppBarWidget({super.key, required this.cartItem});

  @override
  State<StatefulWidget> createState() => _BottomFoodDetailAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(130);
}

class _BottomFoodDetailAppBarWidgetState
    extends State<BottomFoodDetailAppBarWidget> {
  bool _isFavorite = false;
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
       widget.cartItem.quantity = _quantity;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
         widget.cartItem.quantity = _quantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                        onPressed: _decrementQuantity,
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Material(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: IconButton(
                        padding: const EdgeInsets.all(2),
                        icon: const Icon(TablerIcons.plus, color: Colors.green),
                        onPressed: _incrementQuantity,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    _isFavorite ? TablerIcons.heart_filled : TablerIcons.heart,
                    color: _isFavorite
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton.outlined(
                  icon: const Icon(TablerIcons.shopping_cart_plus),
                   onPressed: () {
                    setState(() {
                      Provider.of<CartProvider>(context, listen: false).addToCart(widget.cartItem);
                    });
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
              
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false).addToCart(widget.cartItem);
                      Navigator.pushNamed(context, AppRoutes.cart);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Mua ngay',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

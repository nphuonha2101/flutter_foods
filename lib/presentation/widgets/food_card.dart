import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCard extends StatefulWidget {
  // final Food food;

  // const FoodCard({super.key, this.food});
  const FoodCard({super.key});

  @override
  // State<StatefulWidget> createState() => _FoodCardState({super.key, this.food});
  State<StatefulWidget> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  // late final Food food;

  @override
  void initState() {
    super.initState();
    // food = widget.food;
  }

  _handleCardTapped() {}

  _handleAddToCart() {}
  _handleAddToFavorite() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: _handleCardTapped,
        child: Card(
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Food Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Food Price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: _handleAddToCart,
                          icon: const Icon(Icons.shopping_cart_rounded),
                        ),
                        const SizedBox(width: 10),
                        IconButton.outlined(
                          onPressed: _handleAddToFavorite,
                          icon: const Icon(Icons.favorite_border_rounded),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/food_delivery.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

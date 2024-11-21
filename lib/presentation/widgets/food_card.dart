import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/presentation/screens/food_detail_screen.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCardWidget extends StatefulWidget {
  // final Food food;

  // const FoodCard({super.key, this.food});
  const FoodCardWidget({super.key});

  @override
  // State<StatefulWidget> createState() => _FoodCardState({super.key, this.food});
  State<StatefulWidget> createState() => _FoodCardWidgetState();
}

class _FoodCardWidgetState extends State<FoodCardWidget> {
  late final Food food;

  @override
  void initState() {
    super.initState();
    // food = widget.food;
  }

  _handleCardTapped() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => FoodDetailScreen(food: food),
    //   ),
    // );

    Navigator.of(context).pushNamed(AppRoutes.foodDetail, arguments: {
      'food': food,
    });
  }

  _handleAddToCart() {}
  _handleAddToFavorite() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 9),
      child: InkWell(
        onTap: _handleCardTapped,
        child: Card(
          elevation: 0.5,
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
                        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Food Price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: _handleAddToCart,
                          icon: const Icon(TablerIcons.shopping_cart),
                        ),
                        const SizedBox(width: 10),
                        IconButton.outlined(
                          onPressed: _handleAddToFavorite,
                          icon: const Icon(TablerIcons.heart),
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

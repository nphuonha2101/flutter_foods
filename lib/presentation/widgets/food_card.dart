import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/food.dart';

class FoodCardWidget extends StatefulWidget {
  final Food food;

  const FoodCardWidget({Key? key, required this.food}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FoodCardWidgetState();
}

class _FoodCardWidgetState extends State<FoodCardWidget> {
  late final Food food;

  @override
  void initState() {
    super.initState();
    food = widget.food;
  }

  _handleCardTapped() {
    Navigator.of(context).pushNamed(
      AppRoutes.foodDetail,
      arguments: {'food': food},
    );
  }

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
                      food.name as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(food.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: () {
                            setState(() {
                              // Add to cart functionality here
                            });
                          },
                          icon: const Icon(Icons.shopping_cart),
                        ),
                        const SizedBox(width: 10),
                        IconButton.outlined(
                          onPressed: () {
                            // Add to favorite functionality here
                          },
                          icon: const Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: food.imageUrl as String,  
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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

import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/food.dart';

class FoodSliderItem extends StatelessWidget {
  final Food food;
  const FoodSliderItem({super.key, required this.food});

  // const FoodSliderItem({super.key});

  _onTap() {
    // Navigator.of(context).pushNamed('/food-detail', arguments: food);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/images/food_delivery.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.23,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tên của bánh',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

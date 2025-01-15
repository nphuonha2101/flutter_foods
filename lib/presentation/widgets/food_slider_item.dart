import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/models/food_slider.dart';

class FoodSliderItem extends StatelessWidget {
  final FoodSlider foodSlider;
  const FoodSliderItem({super.key, required this.foodSlider});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            child: Image.network(
              foodSlider.imageUrl ?? ApiConstants.defaultImage,
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
                      foodSlider.title,
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

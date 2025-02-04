import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/food_review.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class UserReviewWidget extends StatelessWidget {
  final FoodReview review;
  
  const UserReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 9),
      child: Card(
        elevation: 0.5,
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/images/user.jpg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   review.title,
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        TablerIcons.star_filled,
                        color: Colors.amber[700],
                      ),
                      const SizedBox(width: 10),
                      const Text('4.5')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
               Text(
                review.content,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

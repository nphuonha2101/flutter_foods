import 'package:flutter_foods/data/dtos/i_dto.dart';

class FoodReviewDto implements IDto {
  final int foodId;
  final int userId;
  final String review;
  final int rating;
  final String title;

  FoodReviewDto({
    required this.foodId,
    required this.userId,
    required this.review,
    required this.rating,
    required this.title,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'user_id': userId,
      'review': review,
      'rating': rating,
      'title': title,
    };
  }

  factory FoodReviewDto.fromJson(Map<String, dynamic> json) {
    return FoodReviewDto(
      foodId: json['food_id'],
      userId: json['user_id'],
      review: json['review'],
      rating: json['rating'],
      title: json['title'],
    );
  }
}

import 'package:flutter_foods/data/dtos/food_review_dto.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class FoodReview implements IModel {
  final int id;
  final int foodId;
  final int userId;
  final String content;
  final int rating;
  final String title;

  FoodReview({
    required this.id,
    required this.foodId,
    required this.userId,
    required this.content,
    required this.rating,
    required this.title,
  });

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return FoodReview(
      id: json['id'],
      foodId: json['food_id'],
      userId: json['user_id'],
      content: json['content'],
      rating: json['rating'],
      title: json['title'],
    );
  }

  @override
  IDto toDto() {
    return FoodReviewDto(
      foodId: foodId,
      userId: userId,
      content: content,
      rating: rating,
      title: title,
    );
  }
}

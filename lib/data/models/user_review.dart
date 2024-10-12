import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/dtos/user_review_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class UserReview implements IModel {
  final String id;
  final String userId;
  final String review;
  final int rating;
  final DateTime createdAt;

  UserReview({
    required this.id,
    required this.userId,
    required this.review,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'review': review,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return UserReview(
      id: json['id'],
      userId: json['userId'],
      review: json['review'],
      rating: json['rating'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  IDto toDto() {
    return UserReviewDto(
      userId: userId,
      review: review,
      rating: rating,
      createdAt: createdAt,
    );
  }
}

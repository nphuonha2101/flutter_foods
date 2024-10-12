import 'package:flutter_foods/data/dtos/i_dto.dart';

class UserReviewDto implements IDto {
  final String userId;
  final String review;
  final int rating;
  final DateTime createdAt;

  UserReviewDto({
    required this.userId,
    required this.review,
    required this.rating,
    required this.createdAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'review': review,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

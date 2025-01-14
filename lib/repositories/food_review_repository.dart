import 'package:flutter_foods/data/dtos/food_review_dto.dart';
import 'package:flutter_foods/data/models/food_review.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';

class FoodReviewRepository
    with AbstractApiRepositories<FoodReview, FoodReviewDto> {
  @override
  FoodReview createModel() {
    return FoodReview(
      id: 0,
      foodId: 0,
      userId: 0,
      review: '',
      rating: 0,
      title: '',
    );
  }
}

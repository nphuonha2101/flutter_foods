import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/dtos/food_review_dto.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/food_review.dart';
import 'package:flutter_foods/repositories/food_review_repository.dart';

class FoodReviewService {
  final FoodReviewRepository _foodReviewRepository;

  FoodReviewService(this._foodReviewRepository);

  Future<List<FoodReview>> fetchByFoodId(int foodId) async {
    try {
      return _foodReviewRepository.fetchByFoodId(foodId);
    } catch (e) {
      throw Exception('Failed to load food reviews. Error: $e');
    }
  }

  Future<bool> createReview(FoodReviewDto review) async {
    try {
      return _foodReviewRepository.createReview(review);
    } catch (e) {
      throw Exception('Failed to create review. Error: $e');
    }
  }

}


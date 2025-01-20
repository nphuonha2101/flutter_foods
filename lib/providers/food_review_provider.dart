import 'package:flutter/material.dart';
import 'package:flutter_foods/data/dtos/food_review_dto.dart';
import 'package:flutter_foods/data/models/food_review.dart';
import 'package:flutter_foods/services/food_review_service.dart';

class FoodReviewProvider with ChangeNotifier {
  final FoodReviewService _foodReviewService;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  FoodReviewProvider(this._foodReviewService);

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<List<FoodReview>> fetchByFoodId(int foodId) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      return await _foodReviewService.fetchByFoodId(foodId);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return [];
  }

  Future<bool> createReview(FoodReviewDto review) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      return await _foodReviewService.createReview(review);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

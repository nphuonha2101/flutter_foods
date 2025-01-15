import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/food_category.dart';
import 'package:flutter_foods/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService _categoryService; 
  List<FoodCategory> _foodCategory = [];  
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  CategoryProvider(this._categoryService);  

  List<FoodCategory> get foodCategory => _foodCategory;  
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<List<FoodCategory>> fetchAll() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _foodCategory = await _categoryService.fetchAllCategories();  
      print(_foodCategory);

    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return _foodCategory;
  }
}

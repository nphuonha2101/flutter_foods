import 'package:flutter_foods/data/models/food_category.dart';
import 'package:flutter_foods/repositories/category_repository.dart';

class CategoryService {
  final CategoryRepository _categoryRepository;

  CategoryService(this._categoryRepository);

  Future<List<FoodCategory>> fetchAllCategories() async {
    try {
      return await _categoryRepository.fetchAll();
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }
}

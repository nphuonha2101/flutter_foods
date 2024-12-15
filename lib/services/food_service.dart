import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/repositories/food_repository.dart';

class FoodService {
  final FoodRepository _foodRepository;

  FoodService(this._foodRepository);

  Future<List<Food>> fetchAll() async {
    try {
      print(123);
      List<Food> items = await _foodRepository.fetchAll();
      print(items);
      return items ;
    } catch (e) {
      throw Exception('Failed to load foods. Error: $e');
    }
  }

  Future<Food> fetch(num id) async {
    try {
      return _foodRepository.fetch(id);
    } catch (e) {
      throw Exception('Failed to load food. Error: $e');
    }
  }

  Future<Food> create(FoodDto food) async {
    try {
      return _foodRepository.create(food);
    } catch (e) {
      throw Exception('Failed to create food. Error: $e');
    }
  }

  Future<Food> update(FoodDto food, num id) async {
    try {
      return _foodRepository.update(food, id);
    } catch (e) {
      throw Exception('Failed to update food. Error: $e');
    }
  }

  Future<void> delete(num id) async {
    try {
      return _foodRepository.delete(id);
    } catch (e) {
      throw Exception('Failed to delete food. Error: $e');
    }
  }
}

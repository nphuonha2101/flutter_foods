
import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';

class FoodRepository with AbstractApiRepositories<Food, FoodDto> {
  @override
  Food createModel() {
      return Food(
      id: 0,
      name: '',
      category: '',
      price: 0,
      rating: 0,
      reviewCount: 0,
      imageUrl: '', 
      angencyId: 0,
    );
  }
 
}

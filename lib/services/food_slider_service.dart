import 'package:flutter_foods/data/models/food_slider.dart';
import 'package:flutter_foods/repositories/food_slider_repository.dart';

class FoodSliderService {
  final FoodSliderRepository _foodSliderRepository;

  FoodSliderService(this._foodSliderRepository);

  Future<List<FoodSlider>> fetchAll() async {
    try {
      return _foodSliderRepository.fetchAll();
    } catch (e) {
      throw Exception('Failed to load food sliders. Error: $e');
    }
  }
}

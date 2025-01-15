import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/food_slider.dart';
import 'package:flutter_foods/services/food_slider_service.dart';

class FoodSliderProvider with ChangeNotifier {
  final FoodSliderService _foodSliderService;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  FoodSliderProvider(this._foodSliderService);

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<List<FoodSlider>> fetchAll() async {
    _isLoading = true;
    _hasError = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    try {
      return (await _foodSliderService.fetchAll()).cast<FoodSlider>();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return [];
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/models/Food.dart';
import 'package:flutter_foods/services/Food_service.dart';

class FoodsProvider with ChangeNotifier {
  final FoodService _foodService;
  List<Food> _foods = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  FoodsProvider(this._foodService);

  List<Food> get foods => _foods;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> fetchAll() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      print("prodiver:" +foods.toString());
      _foods = (await _foodService.fetchAll()).cast<Food>();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> create(FoodDto dto) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _foodService.create(dto);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> update(FoodDto dto, num id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _foodService.update(dto, id);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> delete(num id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _foodService.delete(id);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _foods = [];
    _isLoading = false;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/services/Food_service.dart';

class FoodsProvider with ChangeNotifier {
  final FoodService _foodService;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  FoodsProvider(this._foodService);

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<List<Food>> fetchAllByDistance(
      double latitude, double longitude, double distance) async {
    _isLoading = true;
    _hasError = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    try {
      return (await _foodService.fetchAllByDistance(
              latitude, longitude, distance))
          .cast<Food>();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return [];
  }

  Future<List<Food>> search(String query) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      return (await _foodService.search(query)).cast<Food>();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Food>> fetchAllByCategoryId(String categoryId) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      return (await _foodService.fetchAllByCategoryId(categoryId)).cast<Food>();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Food?> fetch(num id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      return await _foodService.fetch(id);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
    _isLoading = false;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }
}

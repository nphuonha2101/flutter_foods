import 'dart:convert';

import 'package:flutter_foods/data/dtos/food_category_dto.dart';
import 'package:flutter_foods/data/models/food_category.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';

class CategoryRepository
    with AbstractApiRepositories<FoodCategory, FoodCategoryDto> {
  @override
  FoodCategory createModel() {
    return FoodCategory(
      id: 0,
      name: '',
      description: '',
      imageUrl: '',
    );
  }

  @override
  Future<List<FoodCategory>> fetchAll() async {
    final response =
        await http.get(Uri.parse('$baseUrl:$port/api/$version/categories'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final List<dynamic> items = body['data'];

      return items
          .map((item) => createModel().fromJson(item) as FoodCategory)
          .toList();
    } else {
      throw throw Exception('fetch all');
    }
  }
}

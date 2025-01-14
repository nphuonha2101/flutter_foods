import 'dart:convert';
import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';
import 'package:http/http.dart' as http;

class FoodRepository with AbstractApiRepositories<Food, FoodDto> {
  @override
  Food createModel() {
    return Food(
      id: 0,
      name: '',
      category: '',
      description: '',
      price: 0,
      rating: 0,
      reviewCount: 0,
      imageUrl: '',
      shopId: 0,
      distance: 0,
      shopName: '',
    );
  }

  Future<List<Food>> search(String term) async {
    final response = await http.get(
      Uri.parse('$baseApiUrl/search?term=' + term),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final List<dynamic> items = body['data'];
      return items.map((item) => createModel().fromJson(item) as Food).toList();
    } else {
      throw Exception('fetch all: ${response.statusCode}');
    }
  }

  Future<List<Food>> fetchAllByCategoryId(String categoryId) async {
    final response = await http.get(
      Uri.parse('$baseApiUrl?category_id=' + categoryId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final List<dynamic> items = body['data'];
      return items.map((item) => createModel().fromJson(item) as Food).toList();
    } else {
      throw Exception('fetch all: ${response.statusCode}');
    }
  }

  Future<List<Food>> fetchAllByDistance(
      double latitude, double longitude, double distance) async {
    print('$baseApiUrl' +
        '/nearby?latitude=' +
        latitude.toString() +
        '&longitude=' +
        longitude.toString() +
        '&distance=' +
        distance.toString());
    final response = await http.get(
      Uri.parse('$baseApiUrl' +
          '/nearby?latitude=' +
          latitude.toString() +
          '&longitude=' +
          longitude.toString() +
          '&distance=' +
          distance.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> items = body['data'];

      return items.map((item) => createModel().fromJson(item) as Food).toList();
    } else {
      throw Exception('fetch all: ${response.statusCode}');
    }
  }
}

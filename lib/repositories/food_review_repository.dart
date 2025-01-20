import 'dart:convert';

import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/dtos/food_review_dto.dart';
import 'package:flutter_foods/data/models/food_review.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';
import 'package:http/http.dart' as http;

class FoodReviewRepository
    with AbstractApiRepositories<FoodReview, FoodReviewDto> {
      final String apiUrl = ApiConstants.apiUrl.toString();
  @override
  FoodReview createModel() {
    return FoodReview(
      id: 0,
      foodId: 0,
      userId: 0,
      content: '',
      rating: 0,
      title: '',
    );
  }

  Future<List<FoodReview>> fetchByFoodId(int foodId) async {
  final response = await http.get(
    Uri.parse('$apiUrl/food-reviews?food_id=$foodId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  print("Request: ${response.request}");


  print("Response body: ${response.body}");

  if (response.statusCode == 200) {
    try {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> items = body['data'];
      print("Data: $items");

      return items.map((item) => createModel().fromJson(item) as FoodReview).toList();
    } catch (e) {
      print("Error parsing JSON: $e");
      throw Exception('Error parsing response: $e');
    }
  } else {
    throw Exception('fetch all: ${response.statusCode}');
  }
}


  Future<bool> createReview(FoodReviewDto review) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/food-reviews'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(review.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create review: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create review: $e');
    }
  }

}

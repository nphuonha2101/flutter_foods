import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/models/food_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodSliderRepository {
  final String baseApiUrl = ApiConstants.apiUrl + '/slider-items';

  Future<List<FoodSlider>> fetchAll() async {
    final response = await http.get(Uri.parse(baseApiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final List<dynamic> items = body['data'];
      return items
          .map((item) => createModel().fromJson(item) as FoodSlider)
          .toList();
    } else {
      throw _handleError('fetch all', response.statusCode);
    }
  }

  createModel() {
    return FoodSlider(
      imageUrl: '',
      title: '',
    );
  }

  Exception _handleError(String operation, int statusCode) {
    return Exception('Failed to $operation ${'SliderItem'}: HTTP $statusCode');
  }
}

import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class FoodSlider implements IModel {
  final String? imageUrl;
  final String title;

  FoodSlider({
    required this.imageUrl,
    required this.title,
  });

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return FoodSlider(
      imageUrl: json['food']['image'] != null
          ? "${ApiConstants.baseUrl}:${ApiConstants.port}/storage/${json['food']['image']}"
          : null,
      title: json['food']['name'] as String? ?? '',
    );
  }

  @override
  IDto toDto() {
    throw UnimplementedError();
  }
}

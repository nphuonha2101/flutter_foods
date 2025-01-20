import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/dtos/food_category_dto.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class FoodCategory extends IModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  FoodCategory(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl});

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['avatar'] != null
          ? "${ApiConstants.baseUrl}:${ApiConstants.port}/storage/${json['avatar']}"
          : "",
    );
  }

  @override
  IDto toDto() {
    return FoodCategoryDto(
        name: name, description: description, imageUrl: imageUrl);
  }
}

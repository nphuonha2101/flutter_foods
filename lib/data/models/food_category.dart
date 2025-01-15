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
        imageUrl: 'https://img.freepik.com/free-vector/watercolor-japan-food-illustration_23-2149284531.jpg?w=740&t=st=1729140059~exp=1729140659~hmac=c740b7fc08869eabd3cfd73d942558dffe5798ab928e4800d2300fc67be59d26',
      );
    }

    @override
    IDto toDto() {
      return FoodCategoryDto(
          name: name, description: description, imageUrl: imageUrl);
    }
  }

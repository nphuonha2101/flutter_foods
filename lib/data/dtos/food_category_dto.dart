import 'package:flutter_foods/data/dtos/i_dto.dart';

class FoodCategoryDto extends IDto {
  String name;
  String description;
  String imageUrl;

  FoodCategoryDto({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'imageUrl': imageUrl};
  }
}

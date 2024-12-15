import 'package:flutter_foods/data/dtos/i_dto.dart';

class FoodDto implements IDto {
  String? name;
  String? category;
  double price;
  final int angencyId;
  final String? imageUrl;

  FoodDto({
    required this.name,
    required this.category,
    required this.price,
    required this.angencyId,
    required this.imageUrl,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'angencyId': angencyId,
      'imageUrl': imageUrl,
    };
  }
}

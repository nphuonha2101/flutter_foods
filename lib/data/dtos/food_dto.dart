import 'package:flutter_foods/data/dtos/i_dto.dart';

class FoodDto implements IDto {
  String? name;
  String? category;
  double price;
  final int shopId;
  final String? imageUrl;

  FoodDto({
    required this.name,
    required this.category,
    required this.price,
    required this.shopId,
    required this.imageUrl,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'angencyId': shopId,
      'image': imageUrl,
    };
  }
}

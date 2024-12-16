import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class Food implements IModel {
  final int id;
  final String? name;
  final String? category;
  final String? description;
  final double price;
  final double rating;
  final int? reviewCount;
  final int shopId;
  final String? imageUrl;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.shopId,
  });

  @override
  String toString() {
    return 'Food{name: $name, category: $category, price: $price, rating: $rating, reviewCount: $reviewCount, imageUrl: $imageUrl, shopId: $shopId}';
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      description: json['description'],
      rating: json['rating'],
      reviewCount: 0,
      imageUrl: json['image'],
      shopId: json['shop_id'],
    );
  }

  @override
  IDto toDto() {
    return FoodDto(
      name: name,
      category: category,
      price: price,
      shopId: shopId,
      imageUrl: imageUrl,
    );
  }
}

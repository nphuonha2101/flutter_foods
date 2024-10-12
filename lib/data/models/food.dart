import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class Food implements IModel {
  final int id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final int angencyId;
  final String imageUrl;

  Food({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.angencyId,
  });

  @override
  String toString() {
    return 'Food{name: $name, category: $category, price: $price, rating: $rating, reviewCount: $reviewCount, imageUrl: $imageUrl, angencyId: $angencyId}';
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      imageUrl: json['imageUrl'],
      angencyId: json['angencyId'],
    );
  }

  @override
  IDto toDto() {
    return FoodDto(
      name: name,
      category: category,
      price: price,
      angencyId: angencyId,
      imageUrl: imageUrl,
    );
  }
}

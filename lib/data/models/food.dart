import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/core/constants/app.dart';
import 'package:flutter_foods/data/dtos/food_dto.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class Food implements IModel {
  final int id;
  final String? name;
  final String? category;
  final String? description;
  final int price;
  final double rating;
  final int reviewCount;
  final int shopId;
  final String? imageUrl;
  final String shopName;
  final double? distance;

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
    required this.shopName,
    required this.distance,
  });

  @override
  String toString() {
    return 'Food{name: $name, category: $category, price: $price, rating: $rating, reviewCount: $reviewCount, imageUrl: $imageUrl, shopId: $shopId, shopName: $shopName, distance: $distance}';
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['review_count'] as int? ?? 0,
      imageUrl: json['image'] != null
          ? "${ApiConstants.baseUrl}:${ApiConstants.port}/storage/${json['image']}"
          : null,
      shopId: json['shop_id'] as int? ?? 0,
      shopName: json['shop_name'] as String? ?? '',
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : null,
    );
  }

  static IModel fromJsonStatic(Map<String, dynamic> json) {
    return Food(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['review_count'] as int? ?? 0,
      imageUrl: json['image'] != null
          ? "${ApiConstants.baseUrl}:${ApiConstants.port}/storage/${json['image']}"
          : null,
      shopId: json['shop_id'] as int? ?? 0,
      shopName: json['shop_name'] as String? ?? '',
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : null,
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

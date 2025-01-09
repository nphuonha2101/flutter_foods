import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/food.dart';

class FoodCardWidget extends StatelessWidget {
  final Food food;

  const FoodCardWidget({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Card(
        elevation: 4,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh bên trái
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      food.imageUrl as String
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12), 
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên sản phẩm
                    Text(
                      food.name ?? 'No name available',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Tên shop
                    if (food.shopName != null)
                      Text(
                        'Cửa hàng: ${food.shopName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                         maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 6),
                    // Đánh giá
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          food.rating?.toString() ?? 'N/A',
                           style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        ),
                          const SizedBox(width: 6),
                          const Text("|", style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                             const Icon(
                            Icons.location_on,
                            color: Colors.red, 
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                           Text('${food.distance!.toStringAsFixed(2)} km',
                            style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                          ),
                          const SizedBox(width: 2),
  
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Khoảng cách
                    if (food.distance != null)
                      Text(
                        'Đơn giá: ${food.price!.toStringAsFixed(0)} VND',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

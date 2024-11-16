import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/like_food.dart';
import 'package:flutter_foods/presentation/widgets/liked_food_card.dart';

class FavoritePage extends StatelessWidget {
   FavoritePage({super.key});

  void handleFavoriteChange() {
    print("Đã thay đổi trạng thái yêu thích");
  }

  final List<FavoriteFood> favoriteFoods = [
    FavoriteFood(
      imageUrl: "assets/images/food_delivery.png",
      title: "Trà Sữa ToCoToCo - 271 Man Thiện",
      minute: 32,
      rating: 4.6,
      distance: 5.2,
      tags: ["Giảm món", "Siêu ưu đãi"],
    ),
    FavoriteFood(
      imageUrl: "assets/images/food_delivery.png",
      title: "Bánh Mì 3 Tầng - Nguyễn Thị Thập",
      minute: 25,
      rating: 4.8,
      distance: 3.5,
      tags: ["Món mới", "Khuyến mãi"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Yêu thích"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Mới nhất"),
              Tab(text: "Gần tôi"),
            ],
          ),
        ),
        body: Column(
          children: [
            // Filter Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Dịch vụ", style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // List of items
            Expanded(
              child: ListView.builder(
                itemCount: favoriteFoods.length, 
                itemBuilder: (context, index) {
                  final food = favoriteFoods[index]; 
                  return FavoriteCard(
                    imageUrl: food.imageUrl,
                    title: food.title,
                    minute: food.minute,
                    rating: food.rating,
                    distance: food.distance,
                    tags: food.tags,
                    onFavoriteChanged: handleFavoriteChange,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

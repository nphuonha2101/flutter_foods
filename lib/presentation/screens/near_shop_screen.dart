import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/app.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/presentation/widgets/food_card.dart';
import 'package:flutter_foods/providers/foods_provider.dart';
import 'package:flutter_foods/providers/location_provider.dart';
import 'package:provider/provider.dart';

class NearShopScreen extends StatefulWidget {
  const NearShopScreen({super.key});

  @override
  _NearShopScreenState createState() => _NearShopScreenState();
}

class _NearShopScreenState extends State<NearShopScreen> {
  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodsProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cửa Hàng Gần Đây'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Food>>(
        future: foodProvider.fetchAllByDistance(
          locationProvider.latitude ?? 0.0,
          locationProvider.longitude ?? 0.0,
          AppConstants.distanceNearBy,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Food> foods = snapshot.data ?? [];

            if (foods.isEmpty) {
              return const Center(child: Text('No foods found'));
            }

            return ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return FoodCardWidget(food: food); 
              },
            );
          } else {
            return const Center(child: Text('No foods found'));
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_foods/core/constants/app.dart';
import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/food_slider.dart';
import 'package:flutter_foods/data/models/i_model.dart';
import 'package:flutter_foods/presentation/widgets/food_card.dart';
import 'package:flutter_foods/presentation/widgets/food_slider_item.dart';
import 'package:flutter_foods/presentation/widgets/custom_slider.dart';
import 'package:flutter_foods/providers/food_slider_provider.dart';
import 'package:flutter_foods/providers/foods_provider.dart';
import 'package:flutter_foods/providers/location_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Food> foods = [];
  late List<FoodSlider> foodSliders = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final FoodSliderProvider foodSliderProvider =
          Provider.of<FoodSliderProvider>(context, listen: false);
      final foodProvider = Provider.of<FoodsProvider>(context, listen: false);
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);

      List<Food> fetchedFoods = await foodProvider.fetchAllByDistance(
        locationProvider.latitude ?? 0.0,
        locationProvider.longitude ?? 0.0,
        AppConstants.distanceHome,
      );

      List<FoodSlider> fetchedFoodSliders = await foodSliderProvider.fetchAll();

      setState(() {
        foods = fetchedFoods;
        foodSliders = fetchedFoodSliders;
        AppLogger.debug('Food Sliders: $foodSliders');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 3.5 / 10,
            floating: false,
            pinned: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomSlider(
                  height: MediaQuery.of(context).size.height * 0.3,
                  items: foodSliders,
                  itemBuilder: (IModel model) {
                    return FoodSliderItem(foodSlider: model as FoodSlider);
                  }),
            ),
          ),
        ];
      },
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: foods.isEmpty ? 0 : foods.length,
                  itemBuilder: (context, index) {
                    return FoodCardWidget(food: foods[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

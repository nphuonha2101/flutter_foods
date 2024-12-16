  import 'package:flutter/material.dart';
  import 'package:flutter_foods/data/models/food.dart';
  import 'package:flutter_foods/data/models/i_model.dart';
  import 'package:flutter_foods/presentation/widgets/food_card.dart';
  import 'package:flutter_foods/presentation/widgets/food_slider_item.dart';
  import 'package:flutter_foods/presentation/widgets/custom_slider.dart';
  import 'package:flutter_foods/providers/foods_provider.dart';
  import 'package:provider/provider.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    late List<Food> foods = [];

 @override
  void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final foodProvider = Provider.of<FoodsProvider>(context, listen: false);
    await foodProvider.fetchAll(); 
    setState(() {
      foods = foodProvider.foods.cast<Food>();
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
                    items: foods,
                    itemBuilder: (IModel model) {
                      return FoodSliderItem(food: model as Food);
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

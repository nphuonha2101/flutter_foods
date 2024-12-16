import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/food_category.dart';
import 'package:flutter_foods/providers/foods_provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppbarSearchDeligate extends SearchDelegate {
  late Color textColor;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    textColor = Theme.of(context).colorScheme.inverseSurface;

    return themeData.copyWith(
      primaryColor: Theme.of(context).colorScheme.primary,
      primaryIconTheme: themeData.primaryIconTheme
          .copyWith(color: Theme.of(context).colorScheme.inverseSurface),
      primaryTextTheme: themeData.textTheme.copyWith(
        headlineMedium: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 20,
          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        ),
        headlineLarge: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 22,
          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        ),
        headlineSmall: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 18,
          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      textTheme: TextTheme(
        bodySmall: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 16,
          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        ),
        bodyMedium: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 18,
          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        ),
        headlineSmall: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 20,
          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        ),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Tìm kiếm món ăn';

  @override
  TextStyle get searchFieldStyle {
    return TextStyle(
      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
      color: textColor,
      fontSize: 18,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(TablerIcons.clear_all),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(TablerIcons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search result for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? _buildInitialSuggestions(context)
        : _buildSearchResults(context);
  }

  Widget _buildInitialSuggestions(BuildContext context) {
    final recentSearches = ['haha', 'hihi', 'huhu'];
    final List<FoodCategory> foodCategories = [
      FoodCategory(
        id: 1,
        name: 'Mì',
        description: 'Mì là một món ăn ngon',
        imageUrl:
            'https://img.freepik.com/free-vector/watercolor-japan-food-illustration_23-2149284531.jpg?w=740&t=st=1729140059~exp=1729140659~hmac=c740b7fc08869eabd3cfd73d942558dffe5798ab928e4800d2300fc67be59d26',
      ),
      FoodCategory(
        id: 2,
        name: 'Phở',
        description: 'Phở là một món ăn ngon',
        imageUrl:
            'https://img.freepik.com/free-vector/watercolor-japan-food-illustration_23-2149284531.jpg?w=740&t=st=1729140059~exp=1729140659~hmac=c740b7fc08869eabd3cfd73d942558dffe5798ab928e4800d2300fc67be59d26',
      ),
      FoodCategory(
        id: 3,
        name: 'Bún',
        description: 'Bún là một món ăn ngon',
        imageUrl:
            'https://img.freepik.com/free-vector/watercolor-japan-food-illustration_23-2149284531.jpg?w=740&t=st=1729140059~exp=1729140659~hmac=c740b7fc08869eabd3cfd73d942558dffe5798ab928e4800d2300fc67be59d26',
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tìm kiếm gần đây',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      recentSearches.length > 5 ? 5 : recentSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recentSearches[index]),
                      onTap: () {
                        query = recentSearches[index];
                        showResults(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Các loại món ăn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodCategories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          color: Theme.of(context).colorScheme.surface,
                          elevation: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 8, right: 8, bottom: 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    foodCategories[index].imageUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  foodCategories[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
Widget _buildSearchResults(BuildContext context) {
  return FutureBuilder<List<Food>>(
    future: Provider.of<FoodsProvider>(context, listen: false).search(query),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        final foods = snapshot.data!;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 8.0, 
            mainAxisSpacing: 8.0, 
            childAspectRatio: 1, 
          ),
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final food = foods[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.foodDetail,
                  arguments: {'food': food},
                );
              },
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          food.imageUrl as String,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        food.name as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Center(child: Text('No results found.'));
      }
    },
  );
}

}

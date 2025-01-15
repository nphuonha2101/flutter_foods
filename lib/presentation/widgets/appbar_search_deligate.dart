import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/food_category.dart';
import 'package:flutter_foods/providers/category_provider.dart';
import 'package:flutter_foods/providers/foods_provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppbarSearchDeligate extends SearchDelegate {
  late Color textColor;
  late List<String> recentKeywords =[];
 String? selectedCategory;
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
   
    if(query.isEmpty && selectedCategory == null) {
      return 
        Center(
          child: Text('Tìm kiếm kết quả: "$query"')
        );
    }
     if (query.isNotEmpty) {
      saveRecentKeywords();
    }
    if(selectedCategory != null) {
      return _buildSearchByCategory(context);
    }else {
     return _buildSearchResults(context);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? _buildInitialSuggestions(context)
        : _buildSearchResults(context);
  }
  Future<void> getRecentKeywords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentKeywords = prefs.getStringList("RECENT_KEYWORDS") ?? [];
    if (recentKeywords.isEmpty) {
      await prefs.setStringList("RECENT_KEYWORDS", []);
    }
  }

  Widget _buildInitialSuggestions(BuildContext context) {
    getRecentKeywords();
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
                  itemCount: recentKeywords.length > 5 ? 5 : recentKeywords.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recentKeywords[index]),
                      onTap: () {
                        query = recentKeywords[index];
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
                FutureBuilder<List<FoodCategory>>(
                  future: Provider.of<CategoryProvider>(context, listen: false).fetchAll(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Không tìm thấy loại sản phẩm!'));
                    }

                    List<FoodCategory> foodCategories = snapshot.data!;

                    return SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foodCategories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              selectedCategory =foodCategories[index].id.toString() ;
                              showResults(context);
                            },
                            child: Container(
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
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveRecentKeywords () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentKeywords = prefs.getStringList("RECENT_KEYWORDS") ?? [];
    if(recentKeywords.length >= 5) {
      recentKeywords.removeLast();
    }
    if (!recentKeywords.contains(query)) {
      recentKeywords.insert(0, query);
      await prefs.setStringList("RECENT_KEYWORDS", recentKeywords);
    }
  }
 Widget _buildSearchResults(BuildContext context) {
  final future = Provider.of<FoodsProvider>(context, listen: false).search(query);

  return buildFutureResults<Food>(
    context,
    future,
    (context, food) {
      return GestureDetector(
        onTap: () {
          // save recent keywords
          saveRecentKeywords();
          // navigate to food detail
          Navigator.of(context).pushNamed(
            AppRoutes.foodDetail,
            arguments: food,
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
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  food.name as String,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
Widget _buildSearchByCategory(BuildContext context){
  
  final future = Provider.of<FoodsProvider>(context, listen: false)
  .fetchAllByCategoryId(selectedCategory!);

    return buildFutureResults<Food>(
      context,
      future,
      (context, food) {
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
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    food.name as String,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
}

}
Widget buildFutureResults<T>(BuildContext context, Future<List<T>> future, Widget Function(BuildContext, T) itemBuilder) {
  return FutureBuilder<List<T>>(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        final items = snapshot.data!;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return itemBuilder(context, items[index]);
          },
        );
      } else {
        return const Center(child: Text('Không tìm thấy sản phẩm.'));
      }
    },
  );
}

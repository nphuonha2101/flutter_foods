import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/widgets/bottom_food_detail_app_bar.dart';
import 'package:flutter_foods/presentation/widgets/user_review.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomFoodDetailAppBarWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              expandedHeight: MediaQuery.of(context).size.height * 4 / 10,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: kToolbarHeight + 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 10, left: 50, right: 50),
                        child: Image.asset(
                          'assets/images/food_delivery.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Food Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                              fontSize: 20,
                            ),
                          ),
                          Chip(
                            label: const Text('Category'),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            TablerIcons.star_filled,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.amber[700],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '(200 đánh giá)',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '30.000 vnđ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.ibmPlexSans().fontFamily,
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ]),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            'Mô tả',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Mô tả món ăn',
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Đánh giá',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const UserReviewWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

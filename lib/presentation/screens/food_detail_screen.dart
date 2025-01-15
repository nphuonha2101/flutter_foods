import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/data/dtos/food_review_dto.dart';
import 'package:flutter_foods/data/models/auth_credential.dart';
import 'package:flutter_foods/data/models/food_cart_item.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/data/models/food_review.dart';
import 'package:flutter_foods/data/models/user.dart';
import 'package:flutter_foods/presentation/widgets/bottom_food_detail_app_bar.dart';
import 'package:flutter_foods/presentation/widgets/user_review.dart';
import 'package:flutter_foods/providers/food_review_provider.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodDetailScreen extends StatefulWidget {
  final Food food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  late List<FoodReview> reviews = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _fetchFoodReviews();
    });
  }

  Future<void> _fetchFoodReviews() async {
    final provider = Provider.of<FoodReviewProvider>(context, listen: false);

    try {
      List<FoodReview> foodReviews = await provider.fetchByFoodId(widget.food.id);
      setState(() {
        reviews = foodReviews;
      });
    } catch (e) {
      // Handle error if needed
      print('Error fetching food reviews: $e');
    }
  }

  void _showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Viết đánh giá",
            style: TextStyle(fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: "Tiêu đề đánh giá", filled: true),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contentController,
                decoration:
                    const InputDecoration(hintText: "Nội dung", filled: true),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text('Gửi'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
        String? credentialJson = prefs.getString('credential');
        AuthCredential authCredential =
            AuthCredential.fromJson(jsonDecode(credentialJson!));
                // Handle submit action
                final provider = Provider.of<FoodReviewProvider>(context, listen: false);
                final review = FoodReviewDto(
                  foodId: widget.food.id,
                  userId: authCredential.id,
                  title: _titleController.text,
                  content: _contentController.text,
                  rating: _rating.toInt()
                );
                await provider.createReview(review);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomFoodDetailAppBarWidget(
          cartItem: FoodCartItem(food: widget.food, quantity: 1)),
      body: CustomScrollView(
        slivers: [
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
                      child: Image.network(
                        widget.food.imageUrl as String,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
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
                              '${widget.food.name as String}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.ibmPlexSans().fontFamily,
                                fontSize: 20,
                              ),
                            ),
                            Chip(
                              label: Text('${widget.food.shopName as String}'),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                              '${widget.food.rating}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.amber[700],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '(${widget.food.reviewCount} đánh giá)',
                              style: const TextStyle(
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
                              '${widget.food.price} vnđ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.ibmPlexSans().fontFamily,
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              'Mô tả',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.ibmPlexSans().fontFamily,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Đánh giá',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.ibmPlexSans().fontFamily,
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: _showCommentDialog,
                              child: const Text("Đánh giá ngay"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  padding: const EdgeInsets.all(16.0),
  itemCount: reviews.length,
  itemBuilder: (context, index) {
    return UserReviewWidget(review: reviews[index]); // Truyền review vào widget
  },
)

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

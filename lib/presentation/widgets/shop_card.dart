import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ShopCardWidget extends StatefulWidget {

  const ShopCardWidget({super.key});

  @override
  State<StatefulWidget> createState() => _FoodCardWidgetState();
}

class _FoodCardWidgetState extends State<ShopCardWidget> {

  @override
  void initState() {
    super.initState();
  }
  _handleCardTapped() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 9),
      child: InkWell(
        onTap: _handleCardTapped,
        child: Card(
          elevation: 0.5,
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            children: [
              Flexible(
                child: 
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    "assets/images/food_delivery.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shop Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Km",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 10),
                    Text("5 sao",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 10),
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

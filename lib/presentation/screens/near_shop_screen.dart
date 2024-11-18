import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/widgets/shop_card.dart';

class NearShopScreen extends StatelessWidget {
  const NearShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gần đây'),
      ),
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
                  padding: const EdgeInsets.all(10.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const ShopCardWidget();
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
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class BtmNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int?>? onTap;

  const BtmNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.home_2),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.coffee),
          label: 'Drinks',
        ),
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.burger),
          label: 'Food',
        ),
      ],
    );
  }
}

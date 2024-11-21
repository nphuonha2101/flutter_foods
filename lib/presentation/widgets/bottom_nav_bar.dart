import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class BtmNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int?>? onTap;

  const BtmNavigationBarWidget({
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
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
         label: 'Gần đây'
         ),
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.coffee),
          label: 'Đơn hàng của tôi',
        ),
        BottomNavigationBarItem(
          icon: Icon(TablerIcons.user),
          label: 'Tài khoản',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
           label: 'Trang cá nhân'
        ),
      ],
    );
  }
}

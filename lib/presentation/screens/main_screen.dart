import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/screens/home_screen.dart';
import 'package:flutter_foods/presentation/screens/profile_screen.dart';
import 'package:flutter_foods/presentation/screens/my_order_screen.dart';
import 'package:flutter_foods/presentation/widgets/appbar_normal.dart';
import 'package:flutter_foods/presentation/widgets/bottom_nav_bar.dart'
    as custom;
import 'package:flutter_foods/presentation/widgets/slider_drawer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.style2,
      menuBackgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      menuScreen: const SliderDrawerWidget(),
      mainScreen: Scaffold(
        appBar: const AppbarNormalWidget(),
        bottomNavigationBar: custom.BtmNavigationBarWidget(
          currentIndex: _currentIndex,
          onTap: _changePage,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            MyOrderScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}

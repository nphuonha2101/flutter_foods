import 'package:flutter/material.dart';
import 'package:flutter_foods/presentation/screens/cart_screen.dart';
import 'package:flutter_foods/presentation/screens/choose_address_screen.dart';
import 'package:flutter_foods/presentation/screens/food_detail_screen.dart';
import 'package:flutter_foods/presentation/screens/home_screen.dart';
import 'package:flutter_foods/presentation/screens/login_screen.dart';
import 'package:flutter_foods/presentation/screens/order_screen.dart';
import 'package:flutter_foods/presentation/screens/register_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String chooseAddress = '/choose-address';
  static const String foodDetail = '/food-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case chooseAddress:
        return MaterialPageRoute(builder: (_) => const ChooseAddressScreen());
      case foodDetail:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => FoodDetailScreen(
            food: args?['food'],
          ),
        );
      case checkout:
        return MaterialPageRoute(builder: (_) => const OrderScreen());
      case cart:
        // final args = routeSettings.arguments as Map<String, dynamic>;
        // return MaterialPageRoute(
        //   builder: (_) => CartScreen(
        //     items: args['items'],
        //   ),
        // );
        return MaterialPageRoute(builder: (_) => const CartScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}

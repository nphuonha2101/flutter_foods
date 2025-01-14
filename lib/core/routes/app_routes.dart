import 'package:flutter/material.dart';
import 'package:flutter_foods/data/models/food.dart';
import 'package:flutter_foods/presentation/screens/cart_screen.dart';
import 'package:flutter_foods/presentation/screens/address_details_screen.dart';
import 'package:flutter_foods/presentation/screens/choose_address_screen.dart';
import 'package:flutter_foods/presentation/screens/food_detail_screen.dart';
import 'package:flutter_foods/presentation/screens/forgot_password_screen.dart';
import 'package:flutter_foods/presentation/screens/home_screen.dart';
import 'package:flutter_foods/presentation/screens/login_screen.dart';
import 'package:flutter_foods/presentation/screens/order_screen.dart';
import 'package:flutter_foods/presentation/screens/change_password_screen.dart';
import 'package:flutter_foods/presentation/screens/register_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String cart = '/cart';
  static const String chooseAddress = '/choose-address';
  static const String addressDetail = '/address-detail';
  static const String foodDetail = '/food-detail';
  static const String checkout = '/checkout';
  static const String changePassword = '/change-password';

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
      case addressDetail:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AddressDetailsScreen(
            type: args?['type'],
            name: args?['name'],
            phone: args?['phone'],
            address: args?['address'],
            isDefault: args?['isDefault'],
          ),
        );
      case foodDetail:
        final args = routeSettings.arguments as Food;
        return MaterialPageRoute(
          builder: (_) => FoodDetailScreen(
            food: args,
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
       case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());  
       case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
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

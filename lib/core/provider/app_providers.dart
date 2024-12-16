import 'package:flutter/foundation.dart';
import 'package:flutter_foods/providers/cart_provider.dart';
import 'package:flutter_foods/providers/category_provider.dart';
import 'package:flutter_foods/providers/foods_provider.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:flutter_foods/repositories/auth_repository.dart';
import 'package:flutter_foods/repositories/category_repository.dart';
import 'package:flutter_foods/repositories/food_repository.dart';
import 'package:flutter_foods/repositories/user_repository.dart';
import 'package:flutter_foods/services/Food_service.dart';
import 'package:flutter_foods/services/auth_service.dart';
import 'package:flutter_foods/services/category_service.dart';
import 'package:flutter_foods/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../providers/auth_provider.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    // Provider to provide the Repository classes
    Provider<UserRepository>(create: (_) => UserRepository()),
    Provider<AuthRepository>(create: (_) => AuthRepository()),
    Provider<FoodRepository>(create: (_) => FoodRepository()),
    Provider<CategoryRepository>(create: (_) => CategoryRepository()),
    // ProxyProvider to provide the Repository classes to the Service classes
    ProxyProvider<UserRepository, UserService>(
      update: (_, userRepository, __) => UserService(userRepository),
    ),
    ProxyProvider<AuthRepository, AuthService>(
        update: (_, authRepository, __) => AuthService(authRepository)),
    ProxyProvider<FoodRepository, FoodService>(
        update: (_, foodRepository, __) => FoodService(foodRepository)),
    ProxyProvider<CategoryRepository, CategoryService>(
        update: (_, categoryRepository, __) => CategoryService(categoryRepository)),
    // ChangeNotifierProvider to provide methods that will be used in the UI
    // when the state changes it will notify the UI to rebuild
    ChangeNotifierProvider(
      create: (context) => UsersProvider(context.read<UserService>()),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthProvider(context.read<AuthService>()),
    ),
      ChangeNotifierProvider(
      create: (context) => FoodsProvider(context.read<FoodService>()),
    ),
    ChangeNotifierProvider(
      create: (context) => CategoryProvider(context.read<CategoryService>()),
    ),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    
    // Add other providers here
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foods/core/constants/app.dart';
import 'package:flutter_foods/presentation/screens/home_screen.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:flutter_foods/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final UserService userService = UserService();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UsersProvider(userService)),
      // Add other providers here
    ], child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: AppConstants.appName, home: const HomeScreen());
  }
}

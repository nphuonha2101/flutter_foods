import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foods/core/constants/app.dart';
import 'package:flutter_foods/presentation/screens/home_screen.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:flutter_foods/repositories/user_repositories.dart';
import 'package:flutter_foods/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(providers: [
      // Provider to provide the Repository classes
      Provider<UserRepository>(create: (_) => UserRepository()),
      // ProxyProvider to provide the Repository classes to the Service classes
      ProxyProvider<UserRepository, UserService>(
        update: (_, usersProvider, __) => UserService(usersProvider),
      ),

      // ChangeNotifierProvider to provide methods that will be used in the UI
      // when the state changes it will notify the UI to rebuild
      ChangeNotifierProvider(
        create: (context) =>
            UsersProvider(Provider.of<UserRepository>(context, listen: false)),
      ),
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

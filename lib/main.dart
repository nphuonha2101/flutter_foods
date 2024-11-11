import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foods/core/constants/app.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/core/themes/theme.dart';
import 'package:flutter_foods/core/utils/util.dart';
import 'package:flutter_foods/presentation/screens/cart_screen.dart';
import 'package:flutter_foods/presentation/screens/my_order_screen.dart';
import 'package:flutter_foods/presentation/screens/splash_screen.dart';
import 'package:flutter_foods/providers/auth_provider.dart';
import 'package:flutter_foods/providers/users_provider.dart';
import 'package:flutter_foods/repositories/auth_repository.dart';
import 'package:flutter_foods/repositories/user_repository.dart';
import 'package:flutter_foods/services/auth_service.dart';
import 'package:flutter_foods/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(providers: [
      // Provider to provide the Repository classes
      Provider<UserRepository>(create: (_) => UserRepository()),
      Provider<AuthRepository>(create: (_) => AuthRepository()),

      // ProxyProvider to provide the Repository classes to the Service classes
      ProxyProvider<UserRepository, UserService>(
        update: (_, userRepository, __) => UserService(userRepository),
      ),
      ProxyProvider<AuthRepository, AuthService>(
          update: (_, authRepository, __) => AuthService(authRepository)),

      // ChangeNotifierProvider to provide methods that will be used in the UI
      // when the state changes it will notify the UI to rebuild
      ChangeNotifierProvider(
        create: (context) => UsersProvider(context.read<UserService>()),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(context.read<AuthService>()),
      ),
      // Add other providers here
    ], child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "IBM Plex Sans", "Inter");

    MaterialTheme theme = MaterialTheme(textTheme);

    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        title: AppConstants.appName,
        home: const SplashScreen(),
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

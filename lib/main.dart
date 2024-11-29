import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foods/core/constants/app.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/core/themes/theme.dart';
import 'package:flutter_foods/core/utils/util.dart';
import 'package:flutter_foods/presentation/screens/otp_screen.dart';
import 'package:flutter_foods/presentation/screens/splash_screen.dart';
import 'package:flutter_foods/core/provider/app_providers.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(providers: AppProviders.providers, child: const MainApp()),
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
        home: const Otp(),
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

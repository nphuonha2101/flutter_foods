import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foods/presentation/screens/choose_address_screen.dart';
import 'package:flutter_foods/presentation/screens/location_screen.dart';
import 'package:flutter_foods/presentation/screens/main_screen.dart';
import 'package:flutter_foods/providers/location_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _navigateBasedOnPermission();

       Future.delayed(Duration.zero, () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  });
  }

  Future<void> _navigateBasedOnPermission() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    await Future.delayed(const Duration(seconds: 3));

    // Kiểm tra quyền vị trí
    bool permissionGranted = await locationProvider.requestLocationPermission();
    
    if (mounted) {
      if (permissionGranted) {
        await locationProvider.fetchLocation();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
         SystemNavigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(0.0),
            child: Text(
              "Food Delivery",
              style: GoogleFonts.alexBrush(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/food_delivery.png",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

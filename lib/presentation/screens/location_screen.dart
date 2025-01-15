import 'package:flutter/material.dart';
import 'package:flutter_foods/core/routes/app_routes.dart';
import 'package:flutter_foods/providers/location_provider.dart';
import 'package:provider/provider.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    // Kiểm tra và xử lý quyền ngay khi khởi động màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool granted = await locationProvider.requestLocationPermission();
      if (granted) {
        await locationProvider.fetchLocation();
        Navigator.pushNamed(context, AppRoutes.home);
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

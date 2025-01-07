import 'package:flutter/material.dart';
import 'package:flutter_foods/providers/location_provider.dart';
import 'package:provider/provider.dart';
class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Location Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            locationProvider.latitude == null
                ? Text('Vị trí chưa được lấy')
                : Text('Vĩ độ: ${locationProvider.latitude}, Kinh độ: ${locationProvider.longitude}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await locationProvider.getLocation();
              },
              child: Text('Lấy Vị Trí'),
            ),
          ],
        ),
      ),
    );
  }
}
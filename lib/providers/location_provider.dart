import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location location = Location();
  double? latitude;
  double? longitude;

  Future<void> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Kiểm tra dịch vụ vị trí có đang bật không
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Kiểm tra quyền truy cập vị trí
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Lấy vị trí
    LocationData _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;

    notifyListeners();
  }
}

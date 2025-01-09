import 'package:flutter/material.dart';
import 'package:location/location.dart'; // location package
import 'package:permission_handler/permission_handler.dart' as permission_handler; // alias permission_handler

class LocationProvider with ChangeNotifier {
  Location location = Location();
  double? latitude;
  double? longitude;

  // Request location permission
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false; 
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    } 
    return true; 
  }

  // Fetch the current location
  Future<void> fetchLocation() async {
    try {
      LocationData _locationData = await location.getLocation();
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
      print("Current location: ${latitude}, ${longitude}");
      notifyListeners();
    } catch (e) {
      print("Error while fetching location: $e");
    }
  }

 
}

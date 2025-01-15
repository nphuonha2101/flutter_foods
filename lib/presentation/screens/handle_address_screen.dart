import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class HandleAddressScreen extends StatefulWidget {
  const HandleAddressScreen({super.key});

  @override
  State<HandleAddressScreen> createState() => _HandleAddressScreenState();
}

class _HandleAddressScreenState extends State<HandleAddressScreen> {
  final Location _location = Location();
  LatLong _initialPosition = const LatLong(10.762622, 106.660172);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      // Kiểm tra dịch vụ và quyền vị trí
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      // Lấy vị trí hiện tại
      LocationData locationData = await _location.getLocation();
      setState(() {
        _initialPosition =
            LatLong(locationData.latitude!, locationData.longitude!);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Lỗi khi lấy vị trí: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chọn vị trí của bạn"),
      ),
      body: OpenStreetMapSearchAndPick(
        // center: _initialPosition,
        // currentLocationIcon: Icons.location_on,
        buttonColor: Colors.blue,
        buttonText: 'Chọn vị trí',
        onPicked: (pickedData) {
          debugPrint(
              'location: ${pickedData.latLong.latitude}, ${pickedData.latLong.longitude}');
          debugPrint('address: ${pickedData.addressName}');
          Navigator.pop(
            context,
            {
              "address": pickedData.addressName.toString(),
              "latitude": pickedData.latLong.latitude,
              "longitude": pickedData.latLong.longitude,
            },
          );
        },
      ),
    );
  }
}

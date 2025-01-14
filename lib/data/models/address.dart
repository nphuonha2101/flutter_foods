import 'package:flutter_foods/data/dtos/address_dto.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class Address implements IModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String longitude;
  final String latitude;
  final bool isDefault;
  final int userId;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.longitude = "",
    this.latitude = "",
    this.isDefault = false,
    required this.userId,
  });

  @override
  String toString() {
    return 'Address{name: $name, phone: $phone, address: $address, longitude: $longitude, latitude: $latitude, isDefault: $isDefault, userId: $userId}';
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      longitude: json['longitude'] ?? "",
      latitude: json['latitude'] ?? "",
      isDefault: json['default'] == 1,
      userId: json['user_id'],
    );
  }

  @override
  IDto toDto() {
    return AddressDto(
      name: name,
      phone: phone,
      address: address,
      longitude: longitude,
      latitude: latitude,
      isDefault: isDefault ? 1 : 0,
      userId: userId,
    );
  }
}

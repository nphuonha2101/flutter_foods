import 'package:flutter_foods/data/dtos/i_dto.dart';

class AddressDto implements IDto {
  final String name;
  final String phone;
  final String address;
  final String longitude;
  final String latitude;
  final int isDefault;
  final int userId;

  AddressDto({
    required this.name,
    required this.phone,
    required this.address,
    this.longitude = "",
    this.latitude = "",
    this.isDefault = 0,
    required this.userId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'default': isDefault,
      'user_id': userId,
    };
  }
}

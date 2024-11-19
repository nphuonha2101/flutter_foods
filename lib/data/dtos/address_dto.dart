import 'package:flutter_foods/data/dtos/i_dto.dart';

class AddressDto implements IDto {
  final String name;
  final String phone;
  final String address;
  final bool isDefault;

  AddressDto({
    required this.name,
    required this.phone,
    required this.address,
    this.isDefault = false,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'isDefault': isDefault,
    };
  }
}

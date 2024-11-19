import 'package:flutter_foods/data/dtos/address_dto.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class Address implements IModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.isDefault = false,
  });

  @override
  String toString() {
    return 'Address{name: $name, phone: $phone, address: $address, isDefault: $isDefault}';
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      isDefault: json['isDefault'] ?? false,
    );
  }

  @override
  IDto toDto() {
    return AddressDto(
      name: name,
      phone: phone,
      address: address,
      isDefault: isDefault,
    );
  }
}
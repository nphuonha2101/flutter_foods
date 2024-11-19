import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';

class Shop implements IModel {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String longtiude;
  final String logo;
  final String description;
  final String bankName;
  final String bankNumber;

  Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.longtiude,
    required this.logo,
    required this.description,
    required this.bankName,
    required this.bankNumber,
  });

  @override
  String toString() {
    return 'Shop{id: $id, name: $name, address: $address, phone: $phone, email: $email, website: $website, longtiude: $longtiude, logo: $logo, description: $description, bankName: $bankName, bankNumber: $bankNumber}';
  }

  @override
  IModel fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      longtiude: json['longtiude'],
      logo: json['logo'],
      description: json['description'],
      bankName: json['bankName'],
      bankNumber: json['bankNumber'],
    );
  }

  @override
  IDto toDto() {
    throw UnimplementedError();
  }
}

import 'dart:convert';
import 'package:flutter_foods/data/dtos/address_dto.dart';
import 'package:flutter_foods/data/models/address.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';
import 'package:http/http.dart' as http;

class AddressRepository with AbstractApiRepositories<Address, AddressDto> {
  @override
  Address createModel() {
    return Address(
      id: 0,
      name: '',
      phone: '',
      address: '',
      isDefault: false,
    );
  }

  Future<List<Address>> fetchAllByUserId(String userId) async {
    final response = await http.get(
      Uri.parse('$baseApiUrl?user_id=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final List<dynamic> items = body['data'];
      return items
          .map((item) => createModel().fromJson(item) as Address)
          .toList();
    } else {
      throw Exception('fetch all: ${response.statusCode}');
    }
  }
}

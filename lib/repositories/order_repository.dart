import 'dart:convert';

import 'package:flutter_foods/data/dtos/order_dto.dart';
import 'package:flutter_foods/data/models/order.dart';
import 'package:flutter_foods/repositories/abstract_api_repositories.dart';
import 'package:http/http.dart' as http;

class OrderRepository with AbstractApiRepositories<Order, OrderDto> {
  @override
  Order createModel() {
    return Order(
      id: 0,
      shopId: 0,
      totalPrice: 0,
      addressId: 0,
      note: '',
      paymentMethod: '',
      items: [],
      token: ''
    );
  }

  Future<List<Order>> fetchByStatus(int status) async {
    final response = await http.get(
      Uri.parse('$baseApiUrl?status=$status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final List<dynamic> items = body['data'];
      return items
          .map((item) => createModel().fromJson(item) as Order)
          .toList();
    } else {
      throw Exception('fetch all: ${response.statusCode}');
    }
  }

  Future<void> updateStatus(int id, int status) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/update-status/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{'status': status}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update order status');
    }
  }
  Future<Order> store(OrderDto dto) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl:$port/api/$version/$endpoint/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      return createModel().fromJson(json.decode(response.body)) as Order;
    } else {
      throw Exception('Failed to create . Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error while creating: $e');
  }
}
}

import 'dart:convert';

import 'package:flutter_foods/core/log/app_logger.dart';
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
    );
  }

  Future<List<Order>> fetchByStatus(String token, int status) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl?status=$status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      AppLogger.debug(body.toString());

      final List<dynamic> items = body['data'];

      try {
        return items
            .map((item) => createModel().fromJson(item) as Order)
            .toList();
      } catch (e) {
        AppLogger.error('Failed to load orders: $e');
        throw Exception('Failed to load orders');
      }
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
}

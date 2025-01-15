import 'package:flutter_foods/data/dtos/order_dto.dart';
import 'package:flutter_foods/data/models/order.dart';
import 'package:flutter_foods/repositories/order_repository.dart';

class OrderService {
  final OrderRepository _orderRepository;

  OrderService(this._orderRepository);

  Future<List<Order>> fetchAll() async {
    try {
      return _orderRepository.fetchAll();
    } catch (e) {
      throw Exception('Failed to load orders. Error: $e');
    }
  }

  Future<Order> fetch(num id) async {
    try {
      return _orderRepository.fetch(id);
    } catch (e) {
      throw Exception('Failed to load order. Error: $e');
    }
  }

  Future<Order> create(OrderDto order) async {
    try {
      return _orderRepository.store(order);
    } catch (e) {
      throw Exception('Failed to create order. Error: $e');
    }
  }

  Future<void> updateStatus(int id, int status) async {
    try {
      return _orderRepository.updateStatus(id, status);
    } catch (e) {
      throw Exception('Failed to update order status. Error: $e');
    }
  }

  Future<Order> update(OrderDto order, num id) async {
    try {
      return _orderRepository.update(order, id);
    } catch (e) {
      throw Exception('Failed to update order. Error: $e');
    }
  }

  Future<void> delete(num id) async {
    try {
      return _orderRepository.delete(id);
    } catch (e) {
      throw Exception('Failed to delete order. Error: $e');
    }
  }

  Future<List<Order>> fetchByStatus(int status) async {
    try {
      return _orderRepository.fetchByStatus(status);
    } catch (e) {
      throw Exception('Failed to load orders. Error: $e');
    }
  }
}

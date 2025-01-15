import 'package:flutter/material.dart';
import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/data/dtos/order_dto.dart';
import 'package:flutter_foods/data/models/order.dart';
import 'package:flutter_foods/services/order_service.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService;

  OrderProvider(this._orderService);
  List<Order> _orders = [];
  bool _isLoading = false;
  bool _hasError = false;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchAll() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _orders = await _orderService.fetchAll();
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchByStatus(int status) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _orders = await _orderService.fetchByStatus(status);
      AppLogger.debug('OrderProvider: $orders');
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
Future<void> create(OrderDto order) async {
  try {
    await _orderService.create(order);
  } catch (e) {
  }
}


  Future<void> update(OrderDto order, num id) async {
    try {
      await _orderService.update(order, id);
    } catch (e) {
      throw Exception('Failed to update order. Error: $e');
    }
  }

  Future<void> updateStatus(int id, int status) async {
    try {
      await _orderService.updateStatus(id, status);
    } catch (e) {
      throw Exception('Failed to update order status. Error: $e');
    }
  }

  Future<void> delete(num id) async {
    try {
      await _orderService.delete(id);
    } catch (e) {
      throw Exception('Failed to delete order. Error: $e');
    }
  }

  Future<void> cancelOrder(int id) async {
    try {
      await _orderService.updateStatus(id, 3);
    } catch (e) {
      throw Exception('Failed to cancel order. Error: $e');
    }
  }

  void clear() {
    _isLoading = false;
    _hasError = false;
    notifyListeners();
  }
}

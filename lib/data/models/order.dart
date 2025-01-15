import 'package:flutter_foods/core/log/app_logger.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/dtos/order_dto.dart';
import 'package:flutter_foods/data/dtos/order_item_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';
import 'package:flutter_foods/data/models/order_item.dart';

class Order implements IModel {
  final int id;
  final int shopId;
  final int totalPrice;
  final int addressId;
  final String note;
  final int status;
  final String paymentMethod;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.shopId,
    required this.totalPrice,
    required this.addressId,
    this.note = '',
    this.status = 0,
    required this.paymentMethod,
    required this.items,
  });

  @override
  IModel fromJson(Map<String, dynamic> json) {
    AppLogger.debug('Order.fromJson: $json');
    return Order(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      totalPrice: (json['total_price'] as num).toInt(),
      addressId: json['address_id'] as int,
      note: json['note'] as String? ?? '',
      status: json['status'] as int,
      paymentMethod: json['payment_method'] as String,
      items: (json['order_items'] as List)
          .map((item) => OrderItem.fromJsonStatic(item) as OrderItem)
          .toList(),
    );
  }

  @override
  IDto toDto() {
    return OrderDto(
      shopId: shopId,
      totalPrice: totalPrice,
      addressId: addressId,
      note: note,
      paymentMethod: paymentMethod,
      items: items.map((e) => e.toDto() as OrderItemDto).toList(),
    );
  }
}

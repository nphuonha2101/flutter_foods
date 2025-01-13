import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/dtos/order_dto.dart';
import 'package:flutter_foods/data/dtos/order_item_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';
import 'package:flutter_foods/data/models/order_item.dart';

class Order implements IModel {
  final int id;
  final int shopId;
  final double totalPrice;
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
    return Order(
      id: json['id'],
      shopId: json['shop_id'],
      totalPrice: json['total_price'],
      addressId: json['address_id'],
      note: json['note'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      items: (json['order_items'] as List)
          .map((e) => OrderItem.fromJsonStatic(e) as OrderItem)
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

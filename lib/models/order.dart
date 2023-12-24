// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/models/user.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final double totalPrice;
  final int orderedAt;
  final Address address;
  final String userId;
  final int status;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.totalPrice,
    required this.orderedAt,
    required this.address,
    required this.userId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'orderedAt': orderedAt,
      'address': address,
      'userId': userId,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    debugPrint(map.toString());
    return Order(
      id: map['_id'],
      products: List<Product>.from(
        (map['products']).map(
          (x) => Product.fromMap(x['product']),
        ),
      ),
      quantity: List<int>.from(
        map['products'].map(
          (e) => e['quantity'],
        ),
      ),
      totalPrice: double.parse(map['totalPrice'].toString()),
      orderedAt: map['orderedAt'],
      address: Address.fromMap(map['address']),
      userId: map['userId'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);
}

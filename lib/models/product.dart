import 'dart:convert';

import 'package:amazno_clone/models/rating.dart';
import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String description;
  final int quantity;
  final String category;
  final double price;
  final List<String> images;
  final String? id;
  final List<Rating>? ratings;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.price,
    required this.images,
    this.id,
    this.ratings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'category': category,
      'price': price,
      'images': images,
      'id': id,
      'ratings': ratings,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    debugPrint("Here------------");
    return Product(
      name: map['name'],
      description: map['description'],
      quantity: map['quantity'],
      category: map['category'],
      price: double.parse(map['price'].toString()),
      images: List<String>.from(map['images']),
      id: map['_id'],
      ratings: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map<Rating>(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

import 'package:amazno_clone/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String description;
  final String? features;
  final int quantity;
  final String category;
  final double price;
  final double discountedPrice;
  final List<String> images;
  final String? id;
  final List<Rating>? ratings;
  final String sellerName;
  final int unitsSold;
  final int discount;
  Product({
    required this.unitsSold,
    required this.discount,
    required this.name,
    required this.description,
    this.features,
    required this.quantity,
    required this.category,
    required this.price,
    required this.discountedPrice,
    required this.images,
    this.id,
    this.ratings,
    required this.sellerName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'category': category,
      'price': price,
      'discountedPrice': discountedPrice,
      'images': images,
      '_id': id,
      'ratings': ratings,
      'sellerName': sellerName,
      'noOfTimesBought': unitsSold,
      'discount': discount,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    // debugPrint("Here------------");
    return Product(
      name: map['name'],
      description: map['description'],
      features: map['features'],
      quantity: map['quantity'],
      category: map['category'],
      price: double.parse(map['price'].toString()),
      discountedPrice: double.parse(map['discountedPrice'].toString()),
      images: List<String>.from(map['images']),
      id: map['_id'],
      ratings: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map<Rating>(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
      sellerName: map['sellerName'],
      unitsSold: map['unitsSold'],
      discount: map['discount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

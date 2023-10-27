import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String description;
  final double quantity;
  final String category;
  final double price;
  final List<String> images;
  final String? id;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.price,
    required this.images,
    this.id,
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
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: double.parse(map['quantity'].toString()),
      category: map['category'] as String,
      price: double.parse(map['price'].toString()),
      images: List<String>.from(map['images']),
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String email;
  final Address? address;
  final String type;
  final String token;
  final List<dynamic> cart;
  List<String> searchHistory;
  List<String> wishlist;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
    required this.searchHistory,
    required this.wishlist,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
      'searchHistory': searchHistory,
      'wishlist': wishlist,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      address: Address.fromMap(map['address']),
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      searchHistory: List<String>.from(
        map['searchHistory'].map(
          (x) => x.toString(),
        ),
      ),
      wishlist: List<String>.from(
        map['wishlist'].map(
          (x) => x.toString(),
        ),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    Address? address,
    String? type,
    String? token,
    List<dynamic>? cart,
    List<String>? searchHistory,
    List<String>? wishlist,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      searchHistory: searchHistory ?? this.searchHistory,
      wishlist: wishlist ?? this.wishlist,
    );
  }
}

class Address {
  final int houseNo;
  final String street;
  final String locality;
  final String city;
  final String state;
  final int pincode;

  Address({
    required this.houseNo,
    required this.street,
    required this.locality,
    required this.city,
    required this.state,
    required this.pincode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'houseNo': houseNo,
      'street': street,
      'locality': locality,
      'city': city,
      'state': state,
      'pincode': pincode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      houseNo: map['houseNo'] as int,
      street: map['street'] as String,
      locality: map['locality'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      pincode: map['pincode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);
}

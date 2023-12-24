import 'dart:developer';

import 'package:amazno_clone/features/product_details/services/product_detail_services.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/models/rating.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  final ProductDetailsServices productDetailsServices = ProductDetailsServices();
  double _avgRating = 0;
  double _myRating = 0;
  int _carouselIndex = 0;
  int _quantityValue = 1;
  bool _isExpanded = false;
  final CarouselController _carouselController = CarouselController();
  late Product _product;

  List<Map<String, dynamic>> distributiveRating = [
    {
      "star": 5,
      "percent": 0,
      "ratingCount": 0
    },
    {
      "star": 4,
      "percent": 0,
      "ratingCount": 0
    },
    {
      "star": 3,
      "percent": 0,
      "ratingCount": 0
    },
    {
      "star": 2,
      "percent": 0,
      "ratingCount": 0
    },
    {
      "star": 1,
      "percent": 0,
      "ratingCount": 0
    },
  ];

  double get myRating => _myRating;
  double get avgRating => _avgRating;
  int get carouselIndex => _carouselIndex;
  int get quantityValue => _quantityValue;
  bool get isExpanded => _isExpanded;
  CarouselController get carouselController => _carouselController;
  Product get product => _product;

  initialize(Product product, BuildContext context) {
    _product = product;
    distributiveRating = [
      {
        "star": 5,
        "percent": 0,
        "ratingCount": 0
      },
      {
        "star": 4,
        "percent": 0,
        "ratingCount": 0
      },
      {
        "star": 3,
        "percent": 0,
        "ratingCount": 0
      },
      {
        "star": 2,
        "percent": 0,
        "ratingCount": 0
      },
      {
        "star": 1,
        "percent": 0,
        "ratingCount": 0
      },
    ];
    final user = Provider.of<UserProvider>(context, listen: false).user;
    double totalRating = 0;
    for (Rating element in product.ratings ?? []) {
      totalRating += element.rating;
      if (element.userId == user.id) {
        _myRating = element.rating;
      }
    }
    if (totalRating != 0) {
      _avgRating = totalRating / product.ratings!.length.toDouble();
    }
    calculateRating();
    // notifyListeners();
  }

  void addToCart(BuildContext context) {
    productDetailsServices.addtoCart(context: context, product: _product);
  }

  void toggleIsExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  void changeCarouselIndex(int index) {
    _carouselIndex = index;
    notifyListeners();
  }

  String deliveryDate() {
    final dateTime = DateTime.now();
    String formatted = DateFormat("EEEE, d MMMM").format(dateTime.add(const Duration(days: 5)));
    return formatted;
  }

  String remainingTime() {
    DateTime now = DateTime.now();
    List<String> times = [
      '4:45',
      '7:30',
      '12:00',
      '14:30',
      '17:45',
      '21:15',
      '23:00',
      '0:00'
    ];

    for (var time in times) {
      DateTime targetTime = DateTime(now.year, now.month, now.day, int.parse(time.split(':')[0]), int.parse(time.split(':')[1]));
      if (now.isBefore(targetTime)) {
        Duration difference = targetTime.difference(now);
        return "${difference.inHours} h ${difference.inMinutes % 60} mins";
      }
    }
    Duration difference = DateTime(now.year, now.month, now.day, int.parse(times[0].split(':')[0]), int.parse(times[0].split(':')[1])).difference(now);
    return "${difference.inHours} h ${difference.inMinutes % 60} mins";
  }

  void setQuantityValue(int val) {
    _quantityValue = val;
    notifyListeners();
  }

  calculateRating() {
    try {
      for (var element in _product.ratings!) {
        switch (element.rating) {
          case 1.0:
            distributiveRating[4].update('ratingCount', (value) => value + 1);
            break;
          case 2.0:
            distributiveRating[3].update('ratingCount', (value) => value + 1);
            break;
          case 3.0:
            distributiveRating[2].update('ratingCount', (value) => value + 1);
            break;
          case 4.0:
            distributiveRating[1].update('ratingCount', (value) => value + 1);
            break;
          case 5.0:
            distributiveRating[0].update('ratingCount', (value) => value + 1);
            break;
          default:
        }
      }
      for (var element in distributiveRating) {
        element.update('percent', (value) => ((element["ratingCount"] / _product.ratings?.length ?? 1) * 100));
      }
      debugPrint(distributiveRating.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}

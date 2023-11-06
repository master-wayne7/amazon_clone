// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazno_clone/constants/error_handling.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (Map<String, dynamic> e in jsonDecode(res.body)) {
            debugPrint(e['quantity'].runtimeType.toString());

            productList.add(Product.fromMap(e));
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
        name: "",
        description: "",
        quantity: 0,
        category: "",
        price: 0,
        images: []);
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/deal-of-the-day"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
    return product;
  }
}

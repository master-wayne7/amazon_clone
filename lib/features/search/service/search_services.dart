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

class SearchServices {
  Future<List<Product>> fetchSearchedProducts(
      {required BuildContext context, required String searchQuery}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products/search/$searchQuery"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': user.token,
        },
      );
      debugPrint(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (var e in jsonDecode(res.body)) {
            productList.add(Product.fromMap(e));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}

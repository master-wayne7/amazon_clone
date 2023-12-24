// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazno_clone/constants/error_handling.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/features/auth/screens/auth_screen.dart';
import 'package:amazno_clone/models/order.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/orders/me"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (Map<String, dynamic> e in jsonDecode(res.body)) {
            orderList.add(Order.fromMap(e));
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  Future<List<Product>> fetchWishlist({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/get-products"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "productIds": userProvider.user.wishlist,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (Map<String, dynamic> e in jsonDecode(res.body)) {
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

  void logOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('x-auth-token', "");
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

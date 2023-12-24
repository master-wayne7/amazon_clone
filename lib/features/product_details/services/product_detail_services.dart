// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazno_clone/common/service/firebase_dynamic_link.dart';
import 'package:amazno_clone/constants/error_handling.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/models/user.dart';
import 'package:amazno_clone/providers/accounts_provider.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsServices {
  void rateProducts(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/rate-product"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': user.token,
        },
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );
      debugPrint(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addtoCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/user/add-to-cart"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      debugPrint(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateWishlist({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final accountProvider =
        Provider.of<AccountsProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/user/update-wishlist"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'productId': product.id,
          'userId': userProvider.user.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> dynamicWishlist = jsonDecode(res.body)['wishlist'];
          List<String> stringWishlist =
              dynamicWishlist.map((item) => item.toString()).toList();
          debugPrint(stringWishlist.runtimeType.toString());
          User user = userProvider.user.copyWith(wishlist: stringWishlist);
          userProvider.setUserFromModel(user);
          if (userProvider.user.wishlist.contains(product.id)) {
            accountProvider.setIsWishlistLoaded(false);
            showSnackBar(context, "Product added to your wishlist.");
          } else {
            accountProvider.setIsWishlistLoaded(false);
            showSnackBar(context, "Product removed from your wishlist.");
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> shareProduct(Product product) async {
    final text = 'Check out this amazing product: ${product.name}';
    final deepLink = await FirebaseDynamicLinkService.createDynamicLink(
        product.id!, product.images[0]);
    Share.share('$text\n\n$deepLink');
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazno_clone/constants/error_handling.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/models/user.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProducts(
      {required BuildContext context,
      required String searchQuery,
      required bool isSubmitted}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products/search/$searchQuery?submit=$isSubmitted"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token,
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
          if (isSubmitted == true) {
            final existingIndex = userProvider.user.searchHistory.indexWhere(
                (existingQuery) =>
                    existingQuery.toLowerCase() == searchQuery.toLowerCase());
            List<String> history = userProvider.user.searchHistory;
            if (existingIndex != -1) {
              history.insert(
                  0, userProvider.user.searchHistory.removeAt(existingIndex));
            } else {
              history.insert(0, searchQuery);
            }

            if (history.length > 4) {
              history = history.sublist(0, 4);
            }
            User user = userProvider.user.copyWith(searchHistory: history);
            userProvider.setUserFromModel(user);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<void> removeFromHistory(
      {required BuildContext context, required String prompt}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/user/remove-from-history/$prompt"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token,
        },
      );
      debugPrint(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<String> updatedHistory = userProvider.user.searchHistory;
          updatedHistory.remove(prompt);
          User user = userProvider.user.copyWith(searchHistory: updatedHistory);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

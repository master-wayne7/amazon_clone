// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazno_clone/constants/error_handling.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary = CloudinaryPublic("dstqddtjw", "duj2apdq");
      List<String> imageUrls = [];

      for (var image in images) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      var product = Product(
        name: name,
        description: description,
        quantity: quantity,
        category: category,
        price: price,
        images: imageUrls,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product Added Successfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
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

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      var response = await http.post(Uri.parse('$uri/admin/delete-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          },
          body: jsonEncode({'id': product.id}));

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

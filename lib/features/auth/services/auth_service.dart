// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:amazno_clone/common/widgets/bottom_bar.dart';
import 'package:amazno_clone/constants/error_handling.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // sign up user
  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        type: '',
        address: null,
        cart: [],
        token: '',
        searchHistory: [],
        wishlist: [],
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account created! Login with same credentials",
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          'email': email,
          'password': password
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          Map<String, dynamic> responseBody = jsonDecode(res.body);
          String authToken = responseBody['token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
            'x-auth-token',
            authToken,
          );
          Navigator.of(context).pushReplacementNamed(BottomBar.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<String?> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': token!
      });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get the user data
        http.Response userRes = await http.get(Uri.parse("$uri/"), headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': token
        });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        return userProvider.user.token;
      }
    } catch (e) {}
    return null;
  }
}

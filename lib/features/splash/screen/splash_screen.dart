// ignore_for_file: use_build_context_synchronously

import 'package:amazno_clone/common/service/firebase_dynamic_link.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/admin/screens/admin_screen.dart';
import 'package:amazno_clone/features/auth/screens/auth_screen.dart';
import 'package:amazno_clone/features/auth/services/auth_service.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    String? token = await authService.getUserData(context);
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    if (token != null && token.isNotEmpty) {
      if (userProvider.type == "user") {
        await FirebaseDynamicLinkService.initDynamicLink(context);
      } else {
        Navigator.pushReplacementNamed(context, AdminScreen.routeName);
      }
    } else {
      Navigator.pushReplacementNamed(context, AuthScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
      color: Colors.white,
      child: Center(
        child: Lottie.asset(
          "assets/lottie/splash.json",
          frameRate: FrameRate(60),
        ),
      ),
    ));
  }
}

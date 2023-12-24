import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/account/screens/account_screen.dart';
import 'package:amazno_clone/features/cart/screen/cart_screen.dart';
import 'package:amazno_clone/features/home/screens/home_screen.dart';
import 'package:amazno_clone/providers/home_screen_provider.dart';
import 'package:amazno_clone/providers/payment_provider.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  static const String routeName = '/actual-home';
  BottomBar({super.key});

  final double bottomBarWidth = width * .1;
  final double bottomBarBorderWidth = 5;
  final List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.watch<PaymentProvider>();
    final homeProvider = context.watch<HomeScreenProvider>();
    if (paymentProvider.apps == null) {
      paymentProvider.getApps();
    }
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[homeProvider.page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        currentIndex: homeProvider.page,
        onTap: homeProvider.updatePage,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          // home page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: homeProvider.page == 0 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          // profile
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: homeProvider.page == 1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline),
            ),
            label: '',
          ),
          // cart
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: homeProvider.page == 2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  elevation: 0,
                  badgeColor: Colors.white,
                ),
                badgeContent: Text(userCartLength.toString()),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

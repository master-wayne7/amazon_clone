import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/account/widgets/below_appbar.dart';
import 'package:amazno_clone/features/account/widgets/orders.dart';
import 'package:amazno_clone/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: width * 0.3,
                  height: height * 0.06,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications_outlined,
                      ),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppbar(),
          const SizedBox(
            height: 10,
          ),
          TopButtons(),
          const SizedBox(
            height: 10,
          ),
          const Orders(),
        ],
      ),
    );
  }
}

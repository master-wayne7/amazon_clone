import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/account/widgets/single_product.dart';
import 'package:amazno_clone/features/order_details/screen/order_details_screen.dart';
import 'package:amazno_clone/providers/accounts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountsProvider>(context);
    accountProvider.fetchOrders(context);
    return accountProvider.myOrders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Your Orders",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "See all",
                      style: TextStyle(
                        // fontSize: 18,
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // display Orders
              Container(
                height: height * .25,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: accountProvider.myOrders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, OrderDetailScreen.routeName,
                          arguments: accountProvider.myOrders![index]),
                      child: SingleProduct(
                          image: accountProvider
                              .myOrders![index].products[0].images[0]),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map(
          (e) =>
              sum += e['quantity'] * e['product']['discountedPrice'] as double,
        )
        .toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            "Subtotal: ",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            MethodConstants.formatIndianCurrency(sum.toString()),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

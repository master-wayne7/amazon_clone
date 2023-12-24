import 'package:amazno_clone/common/widgets/common_appbar.dart';
import 'package:amazno_clone/common/widgets/custom_button.dart';
import 'package:amazno_clone/features/address/screens/address_screen.dart';
import 'package:amazno_clone/features/cart/widgets/cart_product.dart';
import 'package:amazno_clone/features/cart/widgets/cart_subtotals.dart';
import 'package:amazno_clone/features/home/widgets/address_widget.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void naviagteToAddressScreen(double sum) {
      Navigator.pushNamed(context, AddressScreen.routeName,
          arguments: sum.toString());
    }

    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map(
          (e) =>
              sum += e['quantity'] * e['product']['discountedPrice'] as double,
        )
        .toList();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: "Proceed to Buy (${user.cart.length}) items",
                onTap: () => naviagteToAddressScreen(sum),
                color: Colors.yellow[600],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CartProduct(index: index),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:amazno_clone/features/account/screens/wishlist_screen.dart';
import 'package:amazno_clone/features/account/widgets/account_button.dart';
import 'package:amazno_clone/providers/accounts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopButtons extends StatelessWidget {
  TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountsProvider>(context);
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: () {}),
            AccountButton(text: "Turn Seller", onTap: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: "Log Out",
              onTap: () => accountProvider.logOut(context),
            ),
            AccountButton(
                text: "Your Wishlist",
                onTap: () {
                  accountProvider.fetchWishlist(context);
                  Navigator.pushNamed(context, WishlistScreen.routeName);
                }),
          ],
        ),
      ],
    );
  }
}

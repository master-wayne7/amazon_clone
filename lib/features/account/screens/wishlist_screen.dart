import 'package:amazno_clone/common/widgets/common_appbar.dart';
import 'package:amazno_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazno_clone/features/search/widget/searched_product.dart';
import 'package:amazno_clone/features/shimmer/shimmer_view.dart';
import 'package:amazno_clone/features/shimmer/widgets/wishlist_product.dart';
import 'package:amazno_clone/providers/accounts_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = "/account/wishlist";
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountsProvider>(context);
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CommonAppbar(),
        ),
        body: accountProvider.myWishList == null || accountProvider.isLoading
            ? Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "  Your Wishlist",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return const ShimmerView(child: WishlistProduct());
                          }),
                    ),
                  ],
                ),
              )
            : accountProvider.myWishList?.isEmpty ?? true
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        LottieBuilder.asset(
                          "assets/lottie/empty_wishlist.json",
                        ),
                        const Text("Your wishlist is empty."),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Wishlist",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20, right: 0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: accountProvider.myWishList!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(context,
                                          ProductDetailScreen.routeName,
                                          arguments: accountProvider
                                              .myWishList![index]),
                                      child: SearchedProduct(
                                          product: accountProvider
                                              .myWishList![index]),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}

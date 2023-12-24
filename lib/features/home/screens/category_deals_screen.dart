import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/providers/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CategoryDealsScreen extends StatelessWidget {
  static const String routeName = "/category-deals";
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeScreenProvider>(context);

    return WillPopScope(
      onWillPop: () {
        homeProvider.clear();
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Text(
              category,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: homeProvider.currentCategory == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : homeProvider.currentCategory!.isEmpty
                ? SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset("assets/lottie/empty_wishlist.json"),
                        Text(
                          "Currently no product available in $category\nKeep Shopping for more",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          "Keep shopping for $category",
                          style: const TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: height * .24,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1.4, mainAxisSpacing: 10),
                          itemCount: homeProvider.currentCategory!.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemBuilder: (context, index) {
                            Product product = homeProvider.currentCategory![index];
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.19,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          product.images[0],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(left: 0, top: 5, right: 15),
                                    child: Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

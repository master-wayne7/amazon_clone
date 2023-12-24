import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazno_clone/providers/home_screen_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    homeProvider.fetchDealOfDay(context);

    return homeProvider.dealOfTheDay == null
        ? const Loader()
        : homeProvider.dealOfTheDay!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: homeProvider.dealOfTheDay),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: const Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: homeProvider.dealOfTheDay!.images[0],
                      placeholder: (context, url) => const Loader(),
                      height: height * 0.3,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        MethodConstants.formatIndianCurrency(
                            homeProvider.dealOfTheDay!.price.toString()),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        homeProvider.dealOfTheDay!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: homeProvider.dealOfTheDay!.images
                            .map(
                              (e) => CachedNetworkImage(
                                imageUrl: e,
                                placeholder: (context, url) => const Loader(),
                                fit: BoxFit.fitWidth,
                                width: width * 0.25,
                                height: width * 0.25,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      child: Text(
                        "See all the deals",
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}

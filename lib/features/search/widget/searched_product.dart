import 'package:amazno_clone/common/widgets/custom_button.dart';
import 'package:amazno_clone/common/widgets/stars.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/features/shimmer/shimmer_view.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/models/rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0, avgRating = 0;
    for (Rating element in product.ratings ?? []) {
      totalRating += element.rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length.toDouble();
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              style: BorderStyle.solid,
              width: 0.5,
              color: Color.fromARGB(255, 210, 210, 210),
            ),
          ),
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                color: Colors.grey[200],
                child: Hero(
                  tag: product.images[0],
                  child: CachedNetworkImage(
                    imageUrl: product.images[0],
                    placeholder: (context, url) => ShimmerView(
                      child: Container(
                        height: height * 0.27,
                        width: width * 0.40,
                        color: Colors.black,
                      ),
                    ),
                    fit: BoxFit.contain,
                    height: height * 0.27,
                    width: width * 0.40,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.54,
                child: Column(
                  children: [
                    Container(
                      width: width * 0.5,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 0.9),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "by ${product.sellerName}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Stars(rating: avgRating),
                    ),
                    Container(
                      width: width * 0.5,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        MethodConstants.formatIndianCurrency(product.price.toString()),
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: const Text(
                        "Eligible for Free Shipping",
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CustomButton(
                        text: "Add to Cart",
                        onTap: () {},
                        color: Colors.yellow[600],
                        height: height * 0.055,
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        product.quantity > 0 ? "In Stock" : "Out of Stock",
                        style: TextStyle(color: product.quantity > 0 ? Colors.teal : Color.fromARGB(255, 174, 30, 20)),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

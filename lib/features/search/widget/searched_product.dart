import 'package:amazno_clone/common/widgets/stars.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/models/rating.dart';
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
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 205,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(rating: avgRating),
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "\$${product.price}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "Eligible for Free Shipping",
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      "In Stock",
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

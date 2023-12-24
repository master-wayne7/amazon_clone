import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/reviews/screen/all_reviews_screen.dart';
import 'package:amazno_clone/features/product_details/widgets/review_widget.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ReviewComponent extends StatelessWidget {
  const ReviewComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, AllReviewsScreen.routeName),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer reviews',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    RatingBar.builder(
                      onRatingUpdate: (value) {},
                      initialRating: productProvider.avgRating,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 18,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${productProvider.avgRating} out of 5",
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: GlobalVariables.selectedNavBarColor,
                      size: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${productProvider.product.ratings!.length} global ratings',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Top reviews from India',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...productProvider.product.ratings!
              .take(3)
              .map((e) => ReviewWidget(rating: e))
              .toList(),
        ],
      ),
    );
  }
}

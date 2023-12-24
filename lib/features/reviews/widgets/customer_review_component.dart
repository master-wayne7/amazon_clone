import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CustomerReviewComponent extends StatelessWidget {
  const CustomerReviewComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer reviews',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                "Write a review",
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${productProvider.product.ratings!.length} global ratings',
          ),
          const SizedBox(height: 20),
          ...productProvider.distributiveRating.map((e) => ratingPercentageBar(e["star"], e['percent'])),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: productProvider.toggleIsExpanded,
                    child: productProvider.isExpanded ? const Icon(Icons.keyboard_arrow_up_outlined) : const Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  Text(
                    "How are ratings calculated?",
                    style: TextStyle(
                      fontSize: 15,
                      color: GlobalVariables.selectedNavBarColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (productProvider.isExpanded)
                const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text(
                    "To calculate the overall Star rating and percentage breakdown by star, we don't use a simple average. Instead, our system considers things like how recent a review is and if the reviewer bought the item on Amazon. It also analyses reviews to verify trustworthiness.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ratingPercentageBar(int starNum, double percent) {
    double totalWidth = width * .65 * (percent / 100);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            "$starNum star",
            style: TextStyle(
              color: GlobalVariables.selectedNavBarColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: (width * .65) + 2,
            height: height * 0.035,
            decoration: BoxDecoration(
                color: const Color(0xfff0f2f1),
                border: Border.all(
                  style: BorderStyle.solid,
                  width: 1,
                  color: const Color(0xffbcbebd),
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Container(
                  height: double.maxFinite,
                  width: totalWidth,
                  decoration: BoxDecoration(
                    color: GlobalVariables.secondaryColor,
                    borderRadius: BorderRadius.circular(
                      3,
                    ),
                  ),
                ),
                Container(
                  width: width * .65 * ((100 - percent) / 100),
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: const Color(0xfff0f2f1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "${percent.toInt()}%",
            style: TextStyle(
              color: GlobalVariables.selectedNavBarColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

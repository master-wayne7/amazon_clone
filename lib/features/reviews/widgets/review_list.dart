import 'package:amazno_clone/features/product_details/widgets/review_widget.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewListComponent extends StatelessWidget {
  const ReviewListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return productProvider.product.ratings != null && productProvider.product.ratings!.isNotEmpty
        ? Column(
            children: productProvider.product.ratings!
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ReviewWidget(rating: e),
                  ),
                )
                .toList(),
          )
        : const Center(
            child: Text(
              "Be the first one to review the product.",
            ),
          );
  }
}

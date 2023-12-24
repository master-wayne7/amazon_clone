import 'package:amazno_clone/common/widgets/common_appbar.dart';
import 'package:amazno_clone/features/reviews/widgets/customer_review_component.dart';
import 'package:amazno_clone/features/reviews/widgets/product_title_bar.dart';
import 'package:amazno_clone/features/reviews/widgets/review_list.dart';
import 'package:flutter/material.dart';

class AllReviewsScreen extends StatelessWidget {
  static const routeName = "/product/reviews";
  const AllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppbar(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductTitle(),
            CustomerReviewComponent(),
            ReviewListComponent()
          ],
        ),
      ),
    );
  }
}

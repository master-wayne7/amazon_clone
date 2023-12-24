import 'package:amazno_clone/common/widgets/common_appbar.dart';
import 'package:amazno_clone/features/product_details/widgets/buy_component.dart';
import 'package:amazno_clone/features/product_details/widgets/description_component.dart';
import 'package:amazno_clone/features/product_details/widgets/features_component.dart';
import 'package:amazno_clone/features/product_details/widgets/image_gallery.dart';
import 'package:amazno_clone/features/product_details/widgets/price_component.dart';
import 'package:amazno_clone/features/product_details/widgets/product_spec_component.dart';
import 'package:amazno_clone/features/product_details/widgets/review_component.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.initialize(widget.product, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductSpecComponent(),
            Container(
              margin: const EdgeInsets.only(top: 5),
              color: Colors.black12,
              height: 2,
            ),
            const PriceComponent(),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            const BuyComponent(),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            if (widget.product.category == "Appliances" ||
                widget.product.category == "Mobiles")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FeaturesComponent(),
                  Container(
                    color: Colors.black12,
                    height: 3,
                  ),
                ],
              ),
            const ImageGallery(),
            Container(
              color: Colors.black12,
              height: 3,
            ),
            const DescriptionComponent(),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            if (widget.product.ratings != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ReviewComponent(),
                  Container(
                    color: Colors.black12,
                    height: 3,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

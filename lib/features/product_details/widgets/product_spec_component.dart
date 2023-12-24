import 'package:amazno_clone/common/widgets/stars.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/features/product_details/widgets/animated_dots.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSpecComponent extends StatelessWidget {
  const ProductSpecComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<UserProvider>(context).user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Hero(
              tag: productProvider.product.images[0],
              child: CarouselSlider(
                carouselController: productProvider.carouselController,
                items: productProvider.product.images
                    .map(
                      (e) => Builder(
                        builder: (context) => Image.network(
                          e,
                          fit: BoxFit.contain,
                          height: height * 0.5,
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: productProvider.product.images.length == 1 ? false : true,
                  onPageChanged: (index, reason) => productProvider.changeCarouselIndex(index),
                  viewportFraction: 1,
                  height: height * 0.5,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  productProvider.productDetailsServices.shareProduct(productProvider.product);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  height: 30,
                  width: 30,
                  child: const Center(
                    child: Icon(
                      Icons.share_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 12,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 189, 44, 34),
                ),
                height: 35,
                width: 35,
                child: Center(
                  child: Text(
                    "${productProvider.product.discount}% off",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, height: 0.9, fontSize: 12),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 5,
              child: GestureDetector(
                onTap: () {
                  productProvider.productDetailsServices.updateWishlist(context: context, product: productProvider.product);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  height: 30,
                  width: 30,
                  child: Center(
                    child: Icon(
                      user.wishlist.contains(productProvider.product.id) ? Icons.favorite : Icons.favorite_border,
                      color: user.wishlist.contains(productProvider.product.id) ? Colors.red : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const AnimatedDots(),
        Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Text("${MethodConstants.roundNumber(productProvider.product.unitsSold)}+ bought in past"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Visit ${productProvider.product.sellerName}",
                style: TextStyle(fontSize: 12, color: GlobalVariables.selectedNavBarColor),
              ),
              Row(
                children: [
                  Text(
                    productProvider.avgRating.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                  Stars(rating: productProvider.avgRating),
                  Text(
                    " ${MethodConstants.formatIndianCurrencySystem(productProvider.product.ratings?.length.toString())}",
                    style: TextStyle(fontSize: 12, color: GlobalVariables.selectedNavBarColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10, top: 4),
          child: Text(
            productProvider.product.name,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}

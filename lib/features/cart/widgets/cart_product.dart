import 'package:amazno_clone/common/widgets/stars.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/features/cart/services/cart_services.dart';
import 'package:amazno_clone/features/product_details/services/product_detail_services.dart';
import 'package:amazno_clone/features/shimmer/shimmer_view.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:amazno_clone/models/rating.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    final ProductDetailsServices productDetailsServices =
        ProductDetailsServices();
    final CartServices cartServices = CartServices();
    void increaseQuantity(Product product) {
      productDetailsServices.addtoCart(context: context, product: product);
      setState(() {});
    }

    void decreaseQuantity(Product product) {
      cartServices.removeFromCart(context: context, product: product);
      setState(() {});
    }

    final product = Product.fromMap(user.cart[widget.index]['product']);
    final quantity = user.cart[widget.index]['quantity'];
    double totalRating = 0, avgRating = 0;
    for (Rating element in product.ratings ?? []) {
      totalRating += element.rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length.toDouble();
    }
    return Column(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      style: BorderStyle.solid,
                      width: 0.5,
                      color: Color.fromARGB(255, 210, 210, 210))),
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    color: Colors.grey[200],
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
                  SizedBox(
                    width: width * 0.54,
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.5,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: width * 0.5,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "by ${product.sellerName}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
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
                            MethodConstants.formatIndianCurrency(
                                product.price.toString()),
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black12),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => decreaseQuantity(product),
                                        child: Container(
                                          width: width * 0.08,
                                          height: height * 0.04,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 1.5),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: Container(
                                          width: width * 0.08,
                                          height: height * 0.04,
                                          alignment: Alignment.center,
                                          child: Text(quantity.toString()),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => increaseQuantity(product),
                                        child: Container(
                                          width: width * 0.08,
                                          height: height * 0.04,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.5,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            product.quantity > 0 ? "In Stock" : "Out of Stock",
                            style: TextStyle(
                                color: product.quantity > 0
                                    ? Colors.teal
                                    : Color.fromARGB(255, 174, 30, 20)),
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
        ),
      ],
    );
  }
}

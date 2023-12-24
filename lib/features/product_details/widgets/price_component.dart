import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';

class PriceComponent extends StatelessWidget {
  const PriceComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15)
          .copyWith(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '-${productProvider.product.discount}%',
                style: const TextStyle(
                  fontSize: 38,
                  color: Color.fromARGB(255, 196, 53, 43),
                  fontWeight: FontWeight.w300,
                  height: 0.97,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("₹"),
              Text(
                MethodConstants.formatIndianCurrencySystem(
                  productProvider.product.discountedPrice.toString(),
                ),
                style: const TextStyle(
                  fontSize: 38,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  height: 0.97,
                  letterSpacing: -1.5,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text.rich(
            TextSpan(
              text: "M.R.P.: ",
              style: TextStyle(fontSize: 12.5, color: Colors.grey[600]),
              children: [
                TextSpan(
                  text: MethodConstants.formatIndianCurrency(
                    productProvider.product.price.toString(),
                  ),
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
            child: ClipPath(
              clipper: ConcavePentagonClipper(),
              child: Container(
                padding: const EdgeInsets.only(top: 2, bottom: 3, left: 2.5),
                width: width * 0.2,
                height: height * 0.023,
                color: const Color(0xff3e4750),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/amazon-icon.svg",
                      fit: BoxFit.contain,
                      height: height * 0.022,
                    ),
                    const Center(
                      child: Text(
                        'Fulfilled',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (productProvider.product.price > 20000)
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: "EMI",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    children: [
                      TextSpan(
                        text:
                            " from ${MethodConstants.formatIndianCurrency((productProvider.product.price * 0.02).toString())}. No cost EMI available.",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: " EMI options",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: GlobalVariables.selectedNavBarColor,
                        ),
                      ),
                      const TextSpan(
                        text: "\nInclusive of all taxes",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text.rich(
                    TextSpan(
                      text: "Buy now, pay in EMIs up to",
                      style: TextStyle(
                        fontSize: 15,
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                      children: [
                        const TextSpan(
                          text: " 24 months",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 185, 51, 41),
                          ),
                        ),
                        TextSpan(
                          text: " with Amazon Pay Later",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: GlobalVariables.selectedNavBarColor,
                          ),
                        ),
                        const TextSpan(
                          text: "\nActivate now >",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class ConcavePentagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Adjust these points to create the concave pentagon
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.95, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

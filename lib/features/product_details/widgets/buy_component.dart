import 'package:amazno_clone/common/widgets/custom_button.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/constants/method_constants.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyComponent extends StatelessWidget {
  const BuyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Total: ",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: MethodConstants.formatIndianCurrency(productProvider.product.discountedPrice < 500 ? (productProvider.product.discountedPrice + 100).toString() : productProvider.product.discountedPrice.toString()),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text: productProvider.product.discountedPrice < 500 ? "${MethodConstants.formatIndianCurrency("100")} Delivery" : "FREE delivery ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
                color: GlobalVariables.selectedNavBarColor,
              ),
              children: [
                TextSpan(
                  text: productProvider.deliveryDate(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text: ". Order within ",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: productProvider.remainingTime(),
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 17, 144, 8),
                  ),
                ),
                const TextSpan(
                  text: ". ",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
              ),
              Text(
                "Deliver to ${userProvider.user.name} - ${userProvider.user.address?.city ?? ""} ${userProvider.user.address?.pincode ?? ""}",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.5,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "In Stock",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 17, 144, 8),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: height * 0.045,
            width: width * 0.25,
            decoration: BoxDecoration(color: const Color(0xfff0f2f1), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xffcccecd)), boxShadow: [
              BoxShadow(color: Colors.grey[350]!, blurRadius: 2)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Qty: "),
                DropdownButton<int>(
                    padding: EdgeInsets.zero,
                    value: productProvider.quantityValue,
                    borderRadius: BorderRadius.circular(10),
                    underline: const SizedBox(),
                    isDense: true,
                    iconSize: 27,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                    items: List.generate(
                      10,
                      (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text(
                          (index + 1).toString(),
                        ),
                      ),
                    ),
                    onChanged: (val) => productProvider.setQuantityValue(val!)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: "Add to Cart",
            onTap: () {
              productProvider.addToCart(context);
            },
            color: const Color.fromRGBO(254, 216, 19, 1),
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: "Buy Now",
            onTap: () {},
            color: GlobalVariables.secondaryColor,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(
                Icons.lock,
                color: Colors.grey[500],
                size: 18,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Secure transaction",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.5,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: "Sold by ",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
              ),
              children: [
                TextSpan(
                  text: productProvider.product.sellerName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.5,
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ),
                const TextSpan(
                  text: " and ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.5,
                  ),
                ),
                TextSpan(
                  text: "Fulfilled by Amazon",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.5,
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ),
                const TextSpan(
                  text: ".",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Add to Wish List",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.5,
              color: GlobalVariables.selectedNavBarColor,
            ),
          ),
        ],
      ),
    );
  }
}

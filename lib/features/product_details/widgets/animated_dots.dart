import 'package:amazno_clone/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedDots extends StatelessWidget {
  const AnimatedDots({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return SizedBox(
      height: 15,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          productProvider.product.images.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: productProvider.carouselIndex == index ? 9 * 1.5 : 9,
            height: 9,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              border: productProvider.carouselIndex != index
                  ? Border.all(width: 0.5, color: Colors.grey)
                  : Border.all(width: 0, color: Colors.transparent),
              color: productProvider.carouselIndex == index
                  ? const Color.fromARGB(255, 0, 120, 108)
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

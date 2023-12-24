import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Product image gallery",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...productProvider.product.images.map(
            (e) => Column(
              children: [
                CachedNetworkImage(
                  imageUrl: e,
                  fit: BoxFit.contain,
                  width: double.maxFinite,
                  height: height * 0.3,
                  placeholder: (context, url) => const Loader(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}

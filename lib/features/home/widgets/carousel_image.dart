import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages
          .map(
            (e) => Builder(
              builder: (context) => CachedNetworkImage(
                imageUrl: e,
                placeholder: (context, url) => const Loader(),
                fit: BoxFit.fitHeight,
                height: height * .18,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        height: height * .18,
      ),
    );
  }
}

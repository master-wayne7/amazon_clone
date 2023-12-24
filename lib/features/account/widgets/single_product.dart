import 'package:amazno_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: width * 0.4,
          padding: EdgeInsets.all(10),
          child: Hero(
            tag: image,
            child: Image.network(
              image,
              fit: BoxFit.fitHeight,
              width: width * 0.4,
            ),
          ),
        ),
      ),
    );
  }
}

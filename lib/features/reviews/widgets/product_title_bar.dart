import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: height * 0.07,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12),
      color: Color(0xfff7f7f7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 13,
            ),
          ),
          SizedBox(width: 5),
          Text(
            productProvider.product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

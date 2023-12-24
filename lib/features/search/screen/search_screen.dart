import 'package:amazno_clone/common/widgets/common_appbar.dart';
import 'package:amazno_clone/common/widgets/loader.dart';
import 'package:amazno_clone/features/home/widgets/address_widget.dart';
import 'package:amazno_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazno_clone/features/search/widget/searched_product.dart';
import 'package:amazno_clone/providers/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search-screen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppbar(),
      ),
      body: homeScreenProvider.searchedProduct == []
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: homeScreenProvider.searchedProduct.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            ProductDetailScreen.routeName,
                            arguments:
                                homeScreenProvider.searchedProduct[index]),
                        child: SearchedProduct(
                            product:
                                homeScreenProvider.searchedProduct[index])),
                  ),
                ),
              ],
            ),
    );
  }
}

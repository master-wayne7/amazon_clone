import 'package:amazno_clone/common/widgets/common_appbar.dart';
import 'package:amazno_clone/features/home/widgets/address_widget.dart';
import 'package:amazno_clone/features/home/widgets/carousel_image.dart';
import 'package:amazno_clone/features/home/widgets/deal_of_the_day.dart';
import 'package:amazno_clone/features/home/widgets/top_categories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: CommonAppbar()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            CarouselImage(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}

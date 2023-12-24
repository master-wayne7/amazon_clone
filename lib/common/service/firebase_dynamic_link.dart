// ignore_for_file: use_build_context_synchronously

import 'package:amazno_clone/common/widgets/bottom_bar.dart';
import 'package:amazno_clone/constants/utils.dart';
import 'package:amazno_clone/features/home/service/home_services.dart';
import 'package:amazno_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(String id, String imageUrl) async {
    String linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://amazonclone.page.link',
      link: Uri.parse('https://www.amazonclone.in/product?id=$id'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.amazon_clone',
        minimumVersion: 125,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Amazon.in",
        imageUrl: Uri.parse(imageUrl),
      ),
    );

    ShortDynamicLink url = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    // Uri.parse(url.toString());

    linkMessage = url.shortUrl.toString();
    return linkMessage;
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
      final navContext = Navigator.of(context).context;
      HomeService homeService = HomeService();

      if (initialLink != null) {
        final Uri deepLink = initialLink.link;
        if (deepLink.pathSegments.contains('product')) {
          final productId = deepLink.queryParameters['id'];
          if (productId != null) {
            Product product = await homeService.getProduct(context: context, id: productId);
            Navigator.pushReplacementNamed(context, BottomBar.routeName);
            Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
          }
        } else {
          Navigator.pushReplacementNamed(context, BottomBar.routeName);
        }
      } else {
        Navigator.pushReplacementNamed(context, BottomBar.routeName);
      }

      FirebaseDynamicLinks.instance.onLink.listen(
        (pendingDynamicLinkData) {
          final Uri deepLink = pendingDynamicLinkData.link;
          if (deepLink.pathSegments.contains('product')) {
            final productId = deepLink.queryParameters['id'];
            if (productId != null) {
              Navigator.of(navContext).pushReplacementNamed(BottomBar.routeName);
            }
          } else {
            Navigator.pushReplacementNamed(context, BottomBar.routeName);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

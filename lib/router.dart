import 'package:amazno_clone/common/widgets/bottom_bar.dart';
import 'package:amazno_clone/features/account/screens/wishlist_screen.dart';
import 'package:amazno_clone/features/address/screens/address_screen.dart';
import 'package:amazno_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazno_clone/features/admin/screens/admin_screen.dart';
import 'package:amazno_clone/features/auth/screens/auth_screen.dart';
import 'package:amazno_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazno_clone/features/home/screens/home_screen.dart';
import 'package:amazno_clone/features/order_details/screen/order_details_screen.dart';
import 'package:amazno_clone/features/reviews/screen/all_reviews_screen.dart';
import 'package:amazno_clone/features/product_details/screen/product_detail_screen.dart';
import 'package:amazno_clone/features/search/screen/search_screen.dart';
import 'package:amazno_clone/features/search/screen/search_suggestion_screen.dart';
import 'package:amazno_clone/models/order.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case SearchSuggestionScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SearchSuggestionScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SearchScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case WishlistScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WishlistScreen(),
      );
    case AllReviewsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllReviewsScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BottomBar(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exists."),
          ),
        ),
      );
  }
}

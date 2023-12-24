import 'package:amazno_clone/features/account/services/account_services.dart';
import 'package:amazno_clone/models/order.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:flutter/material.dart';

class AccountsProvider extends ChangeNotifier {
  final AccountServices accountServices = AccountServices();
  List<Order>? myOrders;
  List<Product>? myWishList;
  bool _isWishlistLoaded = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void fetchOrders(context) async {
    if (myOrders == null || myOrders == []) {
      myOrders = await accountServices.fetchMyOrders(context: context);
      notifyListeners();
    }
  }

  setIsWishlistLoaded(bool val) {
    _isWishlistLoaded = val;
    notifyListeners();
  }

  setIsLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> fetchWishlist(context) async {
    if (!_isWishlistLoaded) {
      setIsLoading(true);
      myWishList = await accountServices.fetchWishlist(context: context);
      notifyListeners();
      setIsWishlistLoaded(true);
      setIsLoading(false);
    }
  }

  void logOut(context) {
    accountServices.logOut(context);
  }
}

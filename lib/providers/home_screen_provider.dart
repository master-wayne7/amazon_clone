import 'package:amazno_clone/features/home/service/home_services.dart';
import 'package:amazno_clone/features/search/screen/search_screen.dart';
import 'package:amazno_clone/features/search/service/search_services.dart';
import 'package:amazno_clone/models/product.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  final List<String> _categories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];
  int _page = 0;

  Product? _dealOfTheDay;
  List<String> searchSuggestions = [];
  List<Product> mobiles = [];
  List<Product> essentials = [];
  List<Product> appliances = [];
  List<Product> searchedProduct = [];
  List<Product> books = [];
  List<Product> fashion = [];
  List<Product>? currentCategory;
  HomeService homeService = HomeService();
  SearchServices searchServices = SearchServices();
  final TextEditingController _searchController = TextEditingController();

  int get page => _page;
  TextEditingController get searchController => _searchController;
  Product? get dealOfTheDay => _dealOfTheDay;

  init(context, String category) async {
    if (category == _categories[0] && mobiles.isEmpty) {
      await fetchCategoryProducts(context, category);
    } else if (category == _categories[1] && essentials.isEmpty) {
      await fetchCategoryProducts(context, category);
    } else if (category == _categories[2] && appliances.isEmpty) {
      await fetchCategoryProducts(context, category);
    } else if (category == _categories[3] && books.isEmpty) {
      await fetchCategoryProducts(context, category);
    } else if (category == _categories[4] && fashion.isEmpty) {
      await fetchCategoryProducts(context, category);
    }
    getCategoryProduct(category);
    notifyListeners();
  }

  void updatePage(int index) {
    _page = index;
    notifyListeners();
  }

  fetchCategoryProducts(context, String category) async {
    List<Product>? products = await homeService.fetchCategoryProducts(context: context, category: category);
    if (category == _categories[0]) {
      mobiles = products;
    } else if (category == _categories[1]) {
      essentials = products;
    } else if (category == _categories[2]) {
      appliances = products;
    } else if (category == _categories[3]) {
      books = products;
    } else if (category == _categories[4]) {
      fashion = products;
    }

    notifyListeners();
  }

  getCategoryProduct(category) {
    if (category == _categories[0]) {
      currentCategory = mobiles;
    } else if (category == _categories[1]) {
      currentCategory = essentials;
    } else if (category == _categories[2]) {
      currentCategory = appliances;
    } else if (category == _categories[3]) {
      currentCategory = books;
    } else if (category == _categories[4]) {
      currentCategory = fashion;
    }
    debugPrint(currentCategory.toString());
    notifyListeners();
  }

  void fetchDealOfDay(context) async {
    if (_dealOfTheDay == null) {
      _dealOfTheDay = await homeService.fetchDealOfDay(context: context);
      notifyListeners();
    }
  }

  disposeController() {
    _searchController.clear();

    notifyListeners();
  }

  clear() {
    currentCategory = null;
    notifyListeners();
  }

  setSearchControllerText(String text) {
    searchController.text = text;
    notifyListeners();
  }

  fetchSuggestions(context, String query) async {
    if (query.isNotEmpty && query.trim() != "") {
      var searchedProducts = await searchServices.fetchSearchedProducts(context: context, searchQuery: query.trim(), isSubmitted: false);
      searchSuggestions = searchedProducts.map((e) => e.name).toList();
      notifyListeners();
    } else {
      searchSuggestions = [];
      notifyListeners();
    }
  }

  searchProduct(context, String query) async {
    if (query.isNotEmpty && query.trim() != "") {
      searchedProduct = await searchServices.fetchSearchedProducts(
        context: context,
        searchQuery: query.trim(),
        isSubmitted: true,
      );
      notifyListeners();
      Navigator.pushNamed(context, SearchScreen.routeName);
    } else {
      searchSuggestions = [];
      notifyListeners();
    }
  }

  removeFromHistory(String prompt, BuildContext context) async {
    await searchServices.removeFromHistory(context: context, prompt: prompt);
    notifyListeners();
  }
}

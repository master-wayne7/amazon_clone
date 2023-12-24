import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/search/widget/search_history_suggestion.dart';
import 'package:amazno_clone/features/search/widget/search_product_suggestion.dart';
import 'package:amazno_clone/providers/home_screen_provider.dart';
import 'package:amazno_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSuggestionScreen extends StatelessWidget {
  static const routeName = '/search/suggestions';
  const SearchSuggestionScreen({super.key});
  List<String> splitStringAtBeginning(String input, String searchText) {
    final inputLower = input.toLowerCase();
    final searchTextLower = searchText.toLowerCase();
    final index = inputLower.indexOf(searchTextLower);

    if (index == 0) {
      final firstPart = input.substring(0, searchText.length);
      final secondPart = input.substring(searchText.length);
      return [firstPart, secondPart];
    } else {
      return [input];
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        homeScreenProvider.disposeController();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: SizedBox(
            height: height * 0.05,
            child: TextField(
              onChanged: (value) =>
                  homeScreenProvider.fetchSuggestions(context, value),
              onSubmitted: (value) =>
                  homeScreenProvider.searchProduct(context, value),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 214, 211, 211),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 214, 211, 211),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 214, 211, 211),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                hintText: "Search Amazon.in",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: const Icon(
                  Icons.mic_none_rounded,
                  color: Colors.grey,
                ),
              ),
              controller: homeScreenProvider.searchController,
            ),
          ),
        ),
        body: homeScreenProvider.searchController.text.trim().isEmpty
            ? ListView.builder(
                itemCount: userProvider.user.searchHistory.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SearchHistorySuggestion(
                        text: userProvider.user.searchHistory[index],
                        onTap: () => homeScreenProvider.searchProduct(
                            context, userProvider.user.searchHistory[index]),
                        onCancel: () {
                          homeScreenProvider.removeFromHistory(
                              userProvider.user.searchHistory[index], context);
                        },
                      ),
                      if (index != userProvider.user.searchHistory.length - 1)
                        Divider(color: Colors.grey),
                    ],
                  );
                },
              )
            : ListView.builder(
                itemCount: homeScreenProvider.searchSuggestions.length,
                itemBuilder: (context, index) {
                  List<String> text = splitStringAtBeginning(
                      homeScreenProvider.searchSuggestions[index],
                      homeScreenProvider.searchController.text);
                  return SearchProductSuggestion(
                      text: text,
                      onTap: () => homeScreenProvider.searchProduct(
                          context, homeScreenProvider.searchSuggestions[index]),
                      onSelect: () {
                        homeScreenProvider.setSearchControllerText(
                            homeScreenProvider.searchSuggestions[index]);
                      });
                },
              ),
      ),
    );
  }
}

import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/search/screen/search_screen.dart';
import 'package:amazno_clone/features/search/screen/search_suggestion_screen.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget {
  const CommonAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    void naviagteToSearchScreen(String query) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }

    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 42,
              // margin: EdgeInsets.only(left: 5),
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      style: BorderStyle.solid,
                      width: 1,
                      color: Colors.black12),
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, SearchSuggestionScreen.routeName),
                        child: const SizedBox(
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 5),
                              Text(
                                "Search Amazon.in",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Transform.rotate(
                        angle: 45 * (3.141592653589793 / 180),
                        child: const Icon(
                          Icons.control_camera_rounded,
                          color: Colors.grey,
                          size: 28,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.mic_none_sharp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 42,
            margin: const EdgeInsets.only(left: 10),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

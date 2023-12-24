import 'package:amazno_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class SearchHistorySuggestion extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final VoidCallback onCancel;
  const SearchHistorySuggestion(
      {super.key,
      required this.text,
      required this.onTap,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.05,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTap(),
              child: Row(
                children: [
                  const Icon(
                    Icons.history,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: text,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                            fontSize: 16),
                        children: const [
                          TextSpan(
                            text: " in All Categories",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () => onCancel(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

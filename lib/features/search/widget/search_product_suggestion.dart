import 'package:amazno_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class SearchProductSuggestion extends StatelessWidget {
  final List<String> text;
  final VoidCallback onTap;
  final VoidCallback onSelect;
  const SearchProductSuggestion({
    super.key,
    required this.text,
    required this.onTap,
    required this.onSelect,
  });

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
                    Icons.search,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text.rich(
                      text.length == 2
                          ? TextSpan(
                              text: text[0],
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 16),
                              children: [
                                TextSpan(
                                  text: text[1],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                              ],
                            )
                          : TextSpan(
                              text: text[0],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => onSelect(),
            icon: Transform.flip(
                flipX: true, child: const Icon(Icons.arrow_outward_rounded)),
          ),
        ],
      ),
    );
  }
}

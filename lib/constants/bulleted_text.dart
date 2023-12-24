import 'package:flutter/material.dart';

class BulletedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const BulletedText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    final lines = text.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: lines.map((line) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    '\u2022',
                    style: style.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    line.trim(),
                    style: style,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        );
      }).toList(),
    );
  }
}

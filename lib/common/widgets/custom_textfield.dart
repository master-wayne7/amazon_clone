import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final int maxLines;
  final bool obscureText;
  final TextInputType type;
  final List<String>? autoFillHints;
  final List<TextInputFormatter>? formatter;
  const CustomTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.type = TextInputType.text,
      this.maxLines = 1,
      this.obscureText = false,
      this.formatter,
      this.autoFillHints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      autofillHints: autoFillHints,
      inputFormatters: formatter,
      maxLines: maxLines,
      keyboardType: type,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
    );
  }
}

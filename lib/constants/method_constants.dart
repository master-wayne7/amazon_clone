import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

abstract class MethodConstants {
  static RichText buildRichTextWithBold(String text) {
    final RegExp boldPattern = RegExp(r'\*([^\*]+)\*');
    final List<TextSpan> textSpans = [];

    var currentPosition = 0;
    boldPattern.allMatches(text).forEach((match) {
      final beforeMatch = text.substring(currentPosition, match.start);
      final boldText = match.group(1);

      if (beforeMatch.isNotEmpty) {
        textSpans.add(TextSpan(
          text: beforeMatch,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ));
      }

      if (boldText!.isNotEmpty) {
        textSpans.add(TextSpan(
          text: boldText,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ));
      }

      currentPosition = match.end;
    });

    if (currentPosition < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(currentPosition),
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }

  static String formatDateRating(int date) {
    final parsedDate = DateTime.fromMillisecondsSinceEpoch(date);
    final formattedDate = DateFormat('d MMMM y').format(parsedDate);
    return formattedDate;
  }

  static String formatDate(String? date) {
    if (date == null || date == '' || date == 'null') {
      return 'NA';
    }
    final parsedDate = DateTime.parse(date);
    final formattedDate = DateFormat('d MMMM, y').format(parsedDate);
    return formattedDate;
  }

  static String formatTime(String? date) {
    if (date == null || date == '' || date == 'null') {
      return 'NA';
    }

    DateTime dateTime = DateTime.parse(date);

    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  static String formatIndianCurrency(String? price) {
    if (price == "" || price == null || price == 'null') {
      // return "None ";
      return "NA";
    }
    if (price == 'NA') {
      return 'NA';
    }
    // I added this line so that only numeric value is passed in the int.tryParse
    // otherwise when we pass something like this ₹ 38,000 , it gives error

    String numericValue = price.replaceAll(RegExp(r'[^\d.]'), '');

    String formattedPrice = NumberFormat.currency(
      name: "",
      locale: 'en_IN',
      decimalDigits: numericValue.contains('.') ? 2 : 0,
      symbol: "₹",
    ).format(double.tryParse(numericValue));
    return formattedPrice;
  }

  static String formatIndianCurrencySystem(String? price) {
    if (price == "" || price == null || price == 'null') {
      // return "None ";
      return "NA";
    }
    if (price == 'NA') {
      return 'NA';
    }
    // I added this line so that only numeric value is passed in the int.tryParse
    // otherwise when we pass something like this ₹ 38,000 , it gives error

    String numericValue = price.replaceAll(RegExp(r'[^\d.]'), '');

    String formattedPrice = NumberFormat.currency(
      name: "",
      locale: 'en_IN',
      decimalDigits: numericValue.contains('.') ? 2 : 0,
      symbol: "",
    ).format(double.tryParse(numericValue));
    return formattedPrice;
  }

  static Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    debugPrint('Checking Permission');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      debugPrint('Requesting Permission');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Permission Denied');
        return Future.error('Location permissions are denied');
      }
    }

    // Check Location Service On Or Not
    debugPrint('Checking Location Service');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Requesting Location Service');
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    Position currentLocation = await Geolocator.getCurrentPosition();
    return currentLocation;
  }

  static int roundNumber(int number) {
    if (number < 100) {
      // Round to nearest 5 or 10
      if (number % 10 <= 4) {
        return (number ~/ 10) * 10;
      } else if (number % 10 <= 9) {
        return ((number ~/ 10) * 10) + 5;
      } else {
        return number;
      }
    } else {
      // Round to nearest 50 or 100
      if (number % 100 <= 50) {
        return (number ~/ 100) * 100;
      } else {
        return ((number ~/ 100) * 100) + 50;
      }
    }
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedValue = NumberFormat.decimalPattern('en_IN').format(
      int.tryParse(newValue.text.replaceAll(',', '')) ?? "",
    );
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

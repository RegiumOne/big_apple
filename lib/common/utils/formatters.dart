import 'package:intl/intl.dart';

String formatNumber(int number) {
  if (number >= 1000 && number < 1000000) {
    return "${(number / 1000).toStringAsFixed(0)}K";
  } else if (number >= 1000000 && number < 1000000000) {
    return "${(number / 1000000).toStringAsFixed(1)}M";
  } else if (number >= 1000000000) {
    return "${(number / 1000000000).toStringAsFixed(1)}B";
  } else {
    return number.toString();
  }
}

String formatNumber2(int number) {
  final formatter = NumberFormat('#,##0');
  String formattedNumber = formatter.format(number);
  return formattedNumber;
}

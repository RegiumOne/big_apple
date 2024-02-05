import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String yearMonthDayTime() => DateFormat('y MMM d, HH:mm').format(this);
}

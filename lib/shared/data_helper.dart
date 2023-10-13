import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('yyyy-MM-dd');

String formatDate(DateTime date) {
  return formatter.format(date);
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}

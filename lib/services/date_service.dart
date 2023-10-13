List<DateTime> getDatesInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}

bool isWeekend(DateTime checkDate) {
  return checkDate.weekday == 6 || checkDate.weekday == 7;
}

int calculateDays(DateTime startDate, DateTime endDate) {
  var dates = getDatesInBetween(startDate, endDate);
  int numberOfDays = 0;
  for (var date in dates) {
    if (isWeekend(date)) continue;
    numberOfDays += 1;
  }
  return numberOfDays;
}

DateTime getMaxDate(DateTime checkDate, int maxDays) {
  int calculatedDays = 0;
  while (calculatedDays < maxDays) {}

  return checkDate;
}

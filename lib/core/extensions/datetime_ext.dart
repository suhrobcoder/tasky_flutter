extension DateTimeExt on DateTime {
  DateTime getStartOfDay() {
    return DateTime(year, month, day);
  }

  DateTime getStartOfWeek() {
    subtract(Duration(days: weekday - 1));
    return DateTime(year, month, day);
  }
}

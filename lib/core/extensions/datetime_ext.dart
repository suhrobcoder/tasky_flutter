extension DateTimeExt on DateTime {
  DateTime getStartOfDay() {
    return DateTime(year, month, day);
  }

  DateTime getStartOfWeek() {
    var newDate = subtract(Duration(days: weekday - 1));
    return DateTime(newDate.year, newDate.month, newDate.day);
  }
}

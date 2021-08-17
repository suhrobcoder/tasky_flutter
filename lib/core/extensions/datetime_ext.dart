extension DateTimeExt on DateTime {
  DateTime getStartOfDay() {
    return DateTime(year, month, day);
  }

  DateTime getStartOfWeek() {
    var newDate = subtract(Duration(days: weekday - 1));
    return DateTime(newDate.year, newDate.month, newDate.day);
  }

  bool isSameDayWith(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String toPrettyString() {
    var res = "${months[month - 1]} $day";
    if (DateTime.now().year != year) {
      res += " $year";
    }
    return res;
  }
}

const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

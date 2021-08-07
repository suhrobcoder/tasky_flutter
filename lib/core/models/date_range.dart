class DateRange {
  final DateTime startTime;
  final DateTime endTime;

  DateRange(this.startTime, this.endTime);

  DateRange.fromMillis(
    int startTimeInMillis,
    int endTimeInMillis,
  )   : startTime = DateTime.fromMillisecondsSinceEpoch(startTimeInMillis),
        endTime = DateTime.fromMillisecondsSinceEpoch(endTimeInMillis);

  int getStartTimeInMillis() {
    return startTime.millisecondsSinceEpoch;
  }

  int getEndTimeInMillis() {
    return endTime.millisecondsSinceEpoch;
  }
}

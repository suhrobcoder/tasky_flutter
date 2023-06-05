import 'package:tasky/core/extensions/datetime_ext.dart';

class DateRange {
  final DateTime startTime;
  final DateTime endTime;

  DateRange(this.startTime, this.endTime);

  DateRange.fromMillis(
    int startTimeInMillis,
    int endTimeInMillis,
  )   : startTime = DateTime.fromMillisecondsSinceEpoch(startTimeInMillis),
        endTime = DateTime.fromMillisecondsSinceEpoch(endTimeInMillis);

  DateRange.today()
      : startTime = DateTime.now().getStartOfDay(),
        endTime = DateTime.now().getStartOfDay().add(const Duration(days: 1));

  DateRange.thisWeek()
      : startTime = DateTime.now().getStartOfWeek(),
        endTime = DateTime.now().getStartOfDay().add(const Duration(days: 7));

  int getStartTimeInMillis() {
    return startTime.millisecondsSinceEpoch;
  }

  int getEndTimeInMillis() {
    return endTime.millisecondsSinceEpoch;
  }
}

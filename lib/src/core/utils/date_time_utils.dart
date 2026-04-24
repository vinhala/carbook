DateTime beginningOfMonth(DateTime dateTime) =>
    DateTime(dateTime.year, dateTime.month);

DateTime reminderAnchor(DateTime timestamp) =>
    DateTime(timestamp.year, timestamp.month, timestamp.day, 9);

DateTime addMonthsClamped(DateTime dateTime, int months) {
  final totalMonths = dateTime.month + months;
  final yearOffset = (totalMonths - 1) ~/ 12;
  final targetYear = dateTime.year + yearOffset;
  final targetMonth = ((totalMonths - 1) % 12) + 1;
  final maxDay = DateTime(targetYear, targetMonth + 1, 0).day;
  final targetDay = dateTime.day > maxDay ? maxDay : dateTime.day;
  return DateTime(
    targetYear,
    targetMonth,
    targetDay,
    dateTime.hour,
    dateTime.minute,
    dateTime.second,
    dateTime.millisecond,
    dateTime.microsecond,
  );
}

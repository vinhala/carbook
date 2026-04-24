import 'package:carbook/src/core/utils/date_time_utils.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/maintenance_due_status.dart';
import 'package:carbook/src/domain/maintenance_item.dart';
import 'package:carbook/src/domain/maintenance_log_entry.dart';
import 'package:carbook/src/domain/maintenance_time_unit.dart';

MaintenanceDueStatus buildMaintenanceDueStatus({
  required CarProfile profile,
  required MaintenanceItem item,
  required List<MaintenanceLogEntry> logs,
  DateTime? now,
}) {
  final referenceTime = now ?? DateTime.now();
  final latestLog = logs.isEmpty ? null : logs.first;

  if (item.isDistanceBased) {
    final baselineMileage = latestLog?.mileage ?? 0;
    final nextDueMileage = baselineMileage + item.intervalValue;
    final isOverdue = profile.currentMileage > nextDueMileage;

    return MaintenanceDueStatus(
      isOverdue: isOverdue,
      nextDueMileage: nextDueMileage,
      nextDueDate: null,
      overdueMileage: isOverdue
          ? profile.currentMileage - nextDueMileage
          : null,
      remainingMileage: isOverdue
          ? null
          : nextDueMileage - profile.currentMileage,
      overdueDays: null,
      remainingDays: null,
      lastPerformedAt: latestLog?.performedAt,
      lastPerformedMileage: latestLog?.mileage,
    );
  }

  final anchorDate = latestLog?.performedAt ?? profile.firstRegistrationMonth;
  final nextDueDate = _advanceDate(
    anchorDate,
    item.intervalValue,
    item.timeUnit ?? MaintenanceTimeUnit.months,
  );
  final isOverdue = startOfDay(referenceTime).isAfter(startOfDay(nextDueDate));

  return MaintenanceDueStatus(
    isOverdue: isOverdue,
    nextDueMileage: null,
    nextDueDate: nextDueDate,
    overdueMileage: null,
    remainingMileage: null,
    overdueDays: isOverdue
        ? daysBetweenDates(nextDueDate, referenceTime)
        : null,
    remainingDays: isOverdue
        ? null
        : daysBetweenDates(referenceTime, nextDueDate),
    lastPerformedAt: latestLog?.performedAt,
    lastPerformedMileage: latestLog?.mileage,
  );
}

DateTime _advanceDate(
  DateTime anchor,
  int intervalValue,
  MaintenanceTimeUnit unit,
) {
  return switch (unit) {
    MaintenanceTimeUnit.weeks => anchor.add(Duration(days: 7 * intervalValue)),
    MaintenanceTimeUnit.months => addMonthsClamped(anchor, intervalValue),
    MaintenanceTimeUnit.years => addMonthsClamped(anchor, 12 * intervalValue),
  };
}

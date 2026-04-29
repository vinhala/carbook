import 'package:carful/src/domain/maintenance_due_status.dart';
import 'package:carful/src/domain/maintenance_item.dart';
import 'package:carful/src/l10n/generated/app_localizations.dart';
import 'package:carful/src/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatMaintenanceSchedule(
  MaintenanceItem item, {
  required AppLocalizations l10n,
  required String localeName,
  String mileageUnit = 'mi',
}) {
  if (item.isDistanceBased) {
    final interval = NumberFormat.decimalPattern(
      localeName,
    ).format(item.intervalValue);
    return l10n.everyDistance(interval, mileageUnit);
  }

  return l10n.everyTime(
    item.timeUnit!.localizedInterval(l10n, item.intervalValue),
  );
}

String formatMaintenanceDueLabel(
  MaintenanceDueStatus status, {
  required AppLocalizations l10n,
  required String localeName,
  String mileageUnit = 'mi',
}) {
  if (status.nextDueMileage != null) {
    if (status.isOverdue) {
      final overdue = NumberFormat.decimalPattern(
        localeName,
      ).format(status.overdueMileage);
      return l10n.overdueByDistance(overdue, mileageUnit);
    }

    final remaining = NumberFormat.decimalPattern(
      localeName,
    ).format(status.remainingMileage);
    return status.remainingMileage == 0
        ? l10n.dueNow
        : l10n.dueInDistance(remaining, mileageUnit);
  }

  if (status.isOverdue) {
    return status.overdueDays == 1
        ? l10n.overdueByOneDay
        : l10n.overdueByDays(status.overdueDays!);
  }

  return status.remainingDays == 0
      ? l10n.dueToday
      : status.remainingDays == 1
      ? l10n.dueInOneDay
      : l10n.dueInDays(status.remainingDays!);
}

String formatMaintenanceNextTarget(
  MaintenanceDueStatus status, {
  required AppLocalizations l10n,
  required String localeName,
  String mileageUnit = 'mi',
}) {
  if (status.nextDueMileage != null) {
    final nextMileage = NumberFormat.decimalPattern(
      localeName,
    ).format(status.nextDueMileage);
    return l10n.formattedMileage(nextMileage, mileageUnit);
  }

  return DateFormat.yMMMd(localeName).format(status.nextDueDate!);
}

String formatPerformedMileage(
  int mileage, {
  required AppLocalizations l10n,
  required String localeName,
  String mileageUnit = 'mi',
}) {
  final formattedMileage = NumberFormat.decimalPattern(
    localeName,
  ).format(mileage);
  return l10n.formattedMileage(formattedMileage, mileageUnit);
}

IconData maintenanceIconForDescription(String description) {
  final normalized = description.toLowerCase();

  if (normalized.contains('oil')) {
    return Icons.oil_barrel_outlined;
  }
  if (normalized.contains('tire') || normalized.contains('tyre')) {
    return Icons.tire_repair_outlined;
  }
  if (normalized.contains('spark') || normalized.contains('battery')) {
    return Icons.electrical_services_outlined;
  }
  if (normalized.contains('filter') || normalized.contains('air')) {
    return Icons.air_outlined;
  }
  if (normalized.contains('brake')) {
    return Icons.car_repair_outlined;
  }

  return Icons.build_circle_outlined;
}

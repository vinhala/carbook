import 'package:carful/src/domain/maintenance_due_status.dart';
import 'package:carful/src/domain/maintenance_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatMaintenanceSchedule(
  MaintenanceItem item, {
  String mileageUnit = 'mi',
}) {
  if (item.isDistanceBased) {
    final interval = NumberFormat.decimalPattern().format(item.intervalValue);
    return 'Every $interval $mileageUnit';
  }

  return 'Every ${item.timeUnit!.formatInterval(item.intervalValue)}';
}

String formatMaintenanceDueLabel(
  MaintenanceDueStatus status, {
  String mileageUnit = 'mi',
}) {
  if (status.nextDueMileage != null) {
    if (status.isOverdue) {
      final overdue = NumberFormat.decimalPattern().format(
        status.overdueMileage,
      );
      return 'Overdue by $overdue $mileageUnit';
    }

    final remaining = NumberFormat.decimalPattern().format(
      status.remainingMileage,
    );
    return status.remainingMileage == 0
        ? 'Due now'
        : 'Due in $remaining $mileageUnit';
  }

  if (status.isOverdue) {
    return status.overdueDays == 1
        ? 'Overdue by 1 day'
        : 'Overdue by ${status.overdueDays} days';
  }

  return status.remainingDays == 0
      ? 'Due today'
      : status.remainingDays == 1
      ? 'Due in 1 day'
      : 'Due in ${status.remainingDays} days';
}

String formatMaintenanceNextTarget(
  MaintenanceDueStatus status, {
  String mileageUnit = 'mi',
}) {
  if (status.nextDueMileage != null) {
    final nextMileage = NumberFormat.decimalPattern().format(
      status.nextDueMileage,
    );
    return '$nextMileage $mileageUnit';
  }

  return DateFormat.yMMMd().format(status.nextDueDate!);
}

String formatPerformedMileage(int mileage, {String mileageUnit = 'mi'}) {
  final formattedMileage = NumberFormat.decimalPattern().format(mileage);
  return '$formattedMileage $mileageUnit';
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

import 'package:carbook/src/domain/maintenance_schedule_type.dart';
import 'package:carbook/src/domain/maintenance_time_unit.dart';

class MaintenanceItem {
  const MaintenanceItem({
    required this.id,
    required this.carProfileId,
    required this.description,
    required this.scheduleType,
    required this.intervalValue,
    required this.timeUnit,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int carProfileId;
  final String description;
  final MaintenanceScheduleType scheduleType;
  final int intervalValue;
  final MaintenanceTimeUnit? timeUnit;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isDistanceBased => scheduleType == MaintenanceScheduleType.distance;
  bool get isTimeBased => scheduleType == MaintenanceScheduleType.time;
}

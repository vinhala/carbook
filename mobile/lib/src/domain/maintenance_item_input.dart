import 'package:carful/src/domain/maintenance_schedule_type.dart';
import 'package:carful/src/domain/maintenance_time_unit.dart';

class MaintenanceItemInput {
  const MaintenanceItemInput({
    required this.description,
    required this.scheduleType,
    required this.intervalValue,
    this.timeUnit,
  });

  final String description;
  final MaintenanceScheduleType scheduleType;
  final int intervalValue;
  final MaintenanceTimeUnit? timeUnit;
}

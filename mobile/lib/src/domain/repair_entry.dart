import 'package:carbook/src/domain/repair_area.dart';
import 'package:carbook/src/domain/repair_status.dart';
import 'package:carbook/src/domain/repair_urgency.dart';

class RepairEntry {
  const RepairEntry({
    required this.id,
    required this.carProfileId,
    required this.status,
    required this.isModification,
    required this.area,
    required this.urgency,
    required this.title,
    required this.description,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int carProfileId;
  final RepairStatus status;
  final bool isModification;
  final RepairArea area;
  final RepairUrgency? urgency;
  final String title;
  final String? description;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isPlanned => status.isPlanned;
  bool get isCompleted => status.isCompleted;
}

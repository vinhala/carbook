import 'package:carful/src/domain/repair_area.dart';
import 'package:carful/src/domain/repair_part_input.dart';
import 'package:carful/src/domain/repair_status.dart';
import 'package:carful/src/domain/repair_urgency.dart';

class RepairEntryInput {
  const RepairEntryInput({
    required this.status,
    required this.isModification,
    required this.area,
    required this.title,
    required this.parts,
    this.urgency,
    this.description,
    this.completedAt,
  });

  final RepairStatus status;
  final bool isModification;
  final RepairArea area;
  final RepairUrgency? urgency;
  final String title;
  final String? description;
  final DateTime? completedAt;
  final List<RepairPartInput> parts;
}
